-----------------------------------
-- Chocobo Raising
-- Dedicated to 'Friend' the Chocobo. RIP.
--
-- http://www.playonline.com/pcd/update/ff11us/20060822VOL2B1/detail.html
-- https://ffxiclopedia.fandom.com/wiki/Category:Chocobo_Raising
-- https://www.bg-wiki.com/ffxi/Category:Chocobo_Raising
-- https://ffxiclopedia.fandom.com/wiki/Arael%27s_Chocobo_Raising_Guide
-- https://ffxi.gamerescape.com/wiki/Arael%27s_Chocobo_Raising_Guide
-- https://www.ffxionline.com/forum/ffxi-game-related/crafting-synthesis/chocobo-raising-racing-and-digging/63439-chocobo-color-to-egg-stats-fact
-- https://www.ffxiah.com/forum/topic/32770/ninians-guide-to-chocobo-raising-v2/
-- https://docs.google.com/spreadsheets/d/1LluCnhI_LTvxW-Q6X6R2i-_jL9TABEbKcGPBMZOOlYU/edit#gid=0
-- https://ffxiclopedia.fandom.com/wiki/Carnivors_Guide_to_Chocobo_Breeding
-- https://ffxiclopedia.fandom.com/wiki/Chocobo_Raising/Go_on_a_Walk
--
-- VCS Chocobo Trainers
-- San d’Oria: Hantileon : !pos -2.675 -0.100 -105.287 230
-- Bastok: Zopago        : !pos 51.706 -0.126 -109.065 234
-- Windurst: Pulonono    : !pos 130.124 -6.35 -119.341 241
--
-- Eggs
-- NOTE: Purchased eggs and eggs from ISNM have nothing in their exdata!
-- Purchased/quested:
-- CHOCOBO_EGG_FAINTLY_WARM  : !additem 2312
-- CHOCOBO_EGG_SLIGHTLY_WARM : !additem 2314
-- CHOCOBO_EGG_A_BIT_WARM    : !additem 2317
-- ISNM:
-- CHOCOBO_EGG_A_LITTLE_WARM : !additem 2318
-- CHOCOBO_EGG_SOMEWHAT_WARM : !additem 2319
-----------------------------------
require('scripts/globals/chocobo_names')
require('scripts/globals/utils')
-----------------------------------
xi = xi or {}
xi.chocoboRaising = xi.chocoboRaising or {}
xi.chocoboRaising.chocoState = xi.chocoboRaising.chocoState or {}

local debug = utils.getDebugPlayerPrinter(xi.settings.main.DEBUG_CHOCOBO_RAISING)

-----------------------------------
-- Settings
-----------------------------------

-- Length of a day, in seconds (default is 1x day Earth time, in seconds)
-- Other reasonable settings:
-- One Earth day: 86400 seconds (default)
-- One Vana'diel week: 27648 seconds - 7 hours, 40 minutes, 48 seconds Earth time
-- One Vana'diel day: 3456 seconds - 57 minutes, 36 seconds Earth time (1/25 of one Earth day)
xi.chocoboRaising.dayLength        = 86400
xi.chocoboRaising.daysToChick      = 4
xi.chocoboRaising.daysToAdolescent = 19
xi.chocoboRaising.daysToAdult1     = 29
xi.chocoboRaising.daysToAdult2     = 43 -- 'You've done a great job raising this chocobo. Now is the best time to improve its attributes.'
xi.chocoboRaising.daysToAdult3     = 64 -- 'Chocobo's growth seems to have stabilized. The animal has developed quite a distinguished air.'
xi.chocoboRaising.daysToAdult4     = 129 -- Retirement

-- TODO: Make sure all settings are plainly described.
-- TODO: Add settings to disable retirement, with/without infinite stat growth.
-- xi.settings.main.CHOCOBO_RAISING_DISABLE_RETIREMENT  = false, -- true/false.
-- xi.settings.main.CHOCOBO_RAISING_STAT_GROWTH_CAP     = 512,   -- int.

-- Maximum randomness applied to walkEnergyAmount for a given walk
local walkEnergyRandomness = 5

-- The amount of energy taken by: short, medium and long walks (+ a random amount between 0 and walkEnergyRandomness)
local walkEnergyAmount = { 25, 33, 50 }

-- Chance for an event to happen while on a walk (checked as chance < math.random(1, 100))
local walkEventChance = 33

-- The amount of energy taken by: watch over chocobo
local watchOverEnergy = 5

-- https://www.bg-wiki.com/ffxi/Category:Chocobo_Raising
-- Rental chocobos are bred for speed and endurance, so they are automatically at the capped mount speed (+100% of base movement speed) and riding time.
-- Personal chocobos will need the highest Speed rating and the ability Gallop in order to move at the same speed.
-- F is the base grade (0 ranks), up through A to S to SS (+7 ranks)
-- Max ranks is +9: with skills and relevant silks.

-- Chocobo Speed Ratings
xi.chocoboRaising.ridingSpeedBase    =  80
xi.chocoboRaising.ridingSpeedPerRank = 2.5
xi.chocoboRaising.ridingSpeedCap     = 100
-- Ability: Gallop adds 1 rank
-- Purple Race Silks add 1 rank
-- Leads to absolute max of: 80 + (2.5 * 9): 102.5 -> clamped to 100

-- Chocobo Endurance Ratings (minutes)
xi.chocoboRaising.ridingTimeBase    = 17
xi.chocoboRaising.ridingTimePerRank =  4
xi.chocoboRaising.ridingTimeCap     = 45
-- Ability: Canter adds 1 rank
-- Red Race Silks add 1 rank
-- Leads to absolute max of: 17 + (4 * 9): 53 -> clamped to 45

-- These act as multipliers for adding per-rank bonuses to things.
-- F gives base + (0 * bonus)
-- SS gives base + (7 * bonus)
local skillRanks =
{
    F_POOR                = 0,
    E_SUBSTANDARD         = 1,
    D_A_BIT_DEFICIENT     = 2,
    C_AVERAGE             = 3,
    B_BETTER_THAN_AVERAGE = 4,
    A_IMPRESSIVE          = 5,
    S_OUTSTANDING         = 6,
    SS_FIRST_CLASS        = 7,
}

local skillRankBoundaries =
{
    F_POOR                = 31,
    E_SUBSTANDARD         = 63,
    D_A_BIT_DEFICIENT     = 95,
    C_AVERAGE             = 127,
    B_BETTER_THAN_AVERAGE = 159,
    A_IMPRESSIVE          = 191,
    S_OUTSTANDING         = 223,
    SS_FIRST_CLASS        = 255,
}

local numberToRank = function(skill)
    local rank = skillRanks.F_POOR

    -- Since pairs isn't guaranteed to iterate in order, we have
    -- do check against ranks and see if things are greater than
    -- our best-found rank
    for idx, boundary in pairs(skillRankBoundaries) do
        if skill >= boundary and skillRanks[idx] > rank then
            rank = skillRanks[idx]
        end
    end

    return rank
end

xi.chocoboRaising.getPlayerRidingSpeedAndTime = function(player)
    local baseSpeed = xi.chocoboRaising.ridingSpeedBase
    local baseTime  = xi.chocoboRaising.ridingTimeBase

    -- TODO: This should be looking up your registered chocobo, not your
    --     : current raising chocobo.
    local chocoState = player:getChocoboRaisingInfo()

    if chocoState == nil then
        -- TODO: Log
        return baseSpeed, baseTime
    end

    local strRank  = numberToRank(chocoState.strength)
    local endRank  = numberToRank(chocoState.endurance)
    local outSpeed = utils.clamp(baseSpeed + (strRank * xi.chocoboRaising.ridingSpeedPerRank), 0, xi.chocoboRaising.ridingSpeedCap)
    local outTime  = utils.clamp(baseTime + (endRank * xi.chocoboRaising.ridingTimePerRank), 0, xi.chocoboRaising.ridingTimeCap)

    return outSpeed, outTime
end

-- NOTE: These are animation effects, so you can use warp etc.
local glow =
{
    NONE       = 0,
    WARP       = 80,
    RED        = 96,
    BLUE       = 97,
    YELLOW     = 98,
    GREEN      = 99,
    LIGHT_BLUE = 100,
}

local conditions =
{
    -- Negative
    ILL      = 0,
    VERY_ILL = 1,
    SICK     = 2,
    INJURED  = 3,
    SPOILED  = 4,
    BORED    = 5,
    LOVESICK = 6,
    RUN_AWAY = 7,

    -- Positive
    HIGH_SPIRITS       = 8,
    PERKY              = 9,
    EXTREMELY_HAPPY    = 10,
    FULL_OF_ENERGY_1   = 11,
    FULL_OF_ENERGY_2   = 12,
    BRIGHT_AND_FOCUSED = 13,
}

local hasCondition = function(chocoState)
    return chocoState.conditions > 0
end

local getCondition = function(chocoState, condition)
    return utils.mask.getBit(chocoState.conditions, condition)
end

local setCondition = function(chocoState, condition, value)
    chocoState.conditions = utils.mask.setBit(chocoState.conditions, condition, value)
end

local conditionsHealedByItems =
{
    [conditions.ILL] =
    {
        xi.item.CLUMP_OF_TOKOPEKKO_WILDGRASS,
        xi.item.CELERITY_SALAD,
    },
    [conditions.VERY_ILL] =
    {
        xi.item.CLUMP_OF_TOKOPEKKO_WILDGRASS,
        xi.item.CELERITY_SALAD,
    },
    [conditions.SICK] =
    {
        xi.item.CLUMP_OF_GARIDAV_WILDGRASS,
        xi.item.CELERITY_SALAD,
    },
    [conditions.INJURED] =
    {
        xi.item.CLUMP_OF_GAUSEBIT_WILDGRASS,
        xi.item.CELERITY_SALAD,
    },
    [conditions.SPOILED] =
    {
        xi.item.CELERITY_SALAD,
    },
    [conditions.BORED] =
    {
        xi.item.CELERITY_SALAD,
    },
    [conditions.LOVESICK] =
    {
        xi.item.CELERITY_SALAD,
    },
}
utils.unused(conditionsHealedByItems)

local carePlans =
{
    BASIC_CARE               = 0,
    RESTING                  = 1,
    TAKING_A_WALK            = 2,
    LISTENING_TO_MUSIC       = 3,
    EXERCISING_ALONE         = 4,
    EXCERCISING_IN_A_GROUP   = 5,
    PLAYING_WITH_CHILDREN    = 6,
    PLAYING_WITH_CHOCOBOS    = 7,
    CARRYING_PACKAGES        = 8,
    EXHIBITING_TO_THE_PUBLIC = 9,
    DELIVERING_MESSAGES      = 10,
    DIGGING_FOR_TREASURE     = 11,
    ACTING_IN_A_PLAY         = 12,
}

-- http://www.playonline.com/pcd/update/ff11us/20060822VOL2B1/table03en.jpg
-- minor: 1, moderate: 5, major: 10
-- strength, endurance, discernment, receptivity, affection, energy, payment
local carePlanData =
{
    [carePlans.BASIC_CARE              ] = {  1,  1,  1,  1,  -1,  -1, nil },
    [carePlans.RESTING                 ] = {  0,  0,  0,  0,   0,   1, nil },
    [carePlans.TAKING_A_WALK           ] = {  1,  1, -1, -1,  -1,  -1, nil },
    [carePlans.LISTENING_TO_MUSIC      ] = { -1, -1,  1,  1,  -1,  -1, nil },
    [carePlans.EXERCISING_ALONE        ] = {  1,  0, -1, -1,  -1,  -1, nil },
    [carePlans.EXCERCISING_IN_A_GROUP  ] = {  0,  1, -1, -1,  -1,  -1, nil },
    [carePlans.PLAYING_WITH_CHILDREN   ] = { -1, -1,  1,  0,  -1,  -1, nil },
    [carePlans.PLAYING_WITH_CHOCOBOS   ] = { -1, -1,  0,  1,  -1,  -1, nil },
    [carePlans.CARRYING_PACKAGES       ] = {  5,  5, -5, -5, -10,  -5, 100 },
    [carePlans.EXHIBITING_TO_THE_PUBLIC] = { -5, -5,  5,  5, -10,  -5, 100 },
    [carePlans.DELIVERING_MESSAGES     ] = { 10,  0,  0, -5, -10, -10, 100 },
    [carePlans.DIGGING_FOR_TREASURE    ] = {  0, -5, 10,  0, -10, -10, 100 },
    [carePlans.ACTING_IN_A_PLAY        ] = { -5,  0,  0, 10, -10, -10, 100 },
}

local handleStatChange = function(stat, change, max)
    if change > 0 then
        change = change * xi.settings.main.CHOCOBO_RAISING_STAT_POS_MULTIPLIER
    elseif change < 0 then
        change = change * xi.settings.main.CHOCOBO_RAISING_STAT_NEG_MULTIPLIER
    end

    -- TODO: Enum for which stat is changing?
    -- TODO: Handle Green Racing Silks here for energy?
    -- https://ffxiclopedia.fandom.com/wiki/Green_Race_Silks

    stat = utils.clamp(stat + change, 0, max)

    return stat
end

local handleCarePlan = function(player, chocoState, carePlan)
    -- TODO: Take in a multiplier to account for merged time ranges

    chocoState.strength    = handleStatChange(chocoState.strength   , carePlanData[carePlan][1], 255)
    chocoState.endurance   = handleStatChange(chocoState.endurance  , carePlanData[carePlan][2], 255)
    chocoState.discernment = handleStatChange(chocoState.discernment, carePlanData[carePlan][3], 255)
    chocoState.receptivity = handleStatChange(chocoState.receptivity, carePlanData[carePlan][4], 255)
    chocoState.affection   = handleStatChange(chocoState.affection  , carePlanData[carePlan][5], 255)
    chocoState.energy      = handleStatChange(chocoState.energy     , carePlanData[carePlan][6], 100)

    local payment = carePlanData[carePlan][7]

    if payment then
        payment = payment * xi.settings.main.CHOCOBO_RAISING_GIL_MULTIPLIER
        debug(string.format('Care Plan Payment: %d', payment))

        -- TODO: Handle payment
    end
end

-- TODO: Make sure stat changes are clamped 0-255!

local validFoods =
{
--  [itemId]                                = { hunger, affection, energy, strength, endurance, discernment, receptivity, randomAttribute, glow }
    [xi.item.BUNCH_OF_GYSAHL_GREENS]       = { 25, 10,   0, 0, 0, 0, 0, 0, glow.RED    },
    [xi.item.BUNCH_OF_SHARUG_GREENS]       = { 25, 10,   0, 0, 0, 0, 0, 0, glow.RED    },
    [xi.item.BUNCH_OF_AZOUPH_GREENS]       = { 25, 10,   0, 0, 0, 0, 0, 0, glow.RED    },
    [xi.item.CARROT_PASTE]                 = { 25, 10,   0, 0, 0, 0, 0, 0, glow.RED    },
    [xi.item.HERB_PASTE]                   = { 25, 10,   0, 0, 0, 0, 0, 0, glow.RED    },
    [xi.item.VEGETABLE_PASTE]              = { 25, 10,   0, 0, 0, 0, 0, 0, glow.RED    },
    [xi.item.WORM_PASTE]                   = { 25, 10,   0, 0, 0, 0, 0, 0, glow.RED    },
    [xi.item.VOMP_CARROT]                  = { 25, 10,   0, 0, 0, 0, 0, 0, glow.RED    },
    [xi.item.SAN_DORIAN_CARROT]            = { 25, 10,   0, 0, 0, 0, 0, 0, glow.RED    },
    [xi.item.ZEGHAM_CARROT]                = { 25, 10,   0, 0, 0, 0, 0, 0, glow.BLUE   },
    [xi.item.CLUMP_OF_GAUSEBIT_WILDGRASS]  = { 25, 10,   0, 0, 0, 0, 0, 0, glow.YELLOW },
    [xi.item.CLUMP_OF_GARIDAV_WILDGRASS]   = { 25, 10,   0, 0, 0, 0, 0, 0, glow.YELLOW },
    [xi.item.CLUMP_OF_TOKOPEKKO_WILDGRASS] = { 25, 10,   0, 0, 0, 0, 0, 0, glow.YELLOW },
    [xi.item.CHOCOLIXIR]                   = { 50,  0, 100, 0, 0, 0, 0, 0, glow.YELLOW },
    [xi.item.HI_CHOCOLIXIR]                = { 25,  0, 100, 0, 0, 0, 0, 0, glow.YELLOW },
    [xi.item.CHOCOTONIC]                   = { 25, 10,   0, 0, 0, 0, 0, 0, glow.YELLOW },
    [xi.item.CUPID_WORM]                   = { 25, 10,   0, 0, 0, 0, 0, 0, glow.BLUE   },
    [xi.item.GREGARIOUS_WORM]              = { 25, 10,   0, 0, 0, 0, 0, 0, glow.YELLOW },
    [xi.item.PARASITE_WORM]                = { 25, 10,   0, 0, 0, 0, 0, 0, glow.BLUE   },
    [xi.item.TORNADO_SALAD]                = { 25, 10,   0, 0, 0, 0, 0, 0, glow.GREEN  },
    [xi.item.CELERITY_SALAD]               = { 25, 10,   0, 0, 0, 0, 0, 0, glow.GREEN  },
    [xi.item.LETHE_POTAGE]                 = { 25, 10,   0, 0, 0, 0, 0, 0, glow.GREEN  },
    [xi.item.LETHE_CONSOMME]               = { 25, 10,   0, 0, 0, 0, 0, 0, glow.GREEN  },
    [xi.item.LA_THEINE_MILLET]             = { 25, 10,   0, 0, 0, 0, 0, 0, glow.GREEN  },
--  [xi.item.SCROLL_OF_INSTANT_WARP]       = { 0, 0, 0, 0, 0, 0, 0, 0, glow.WARP },
}

-- Items that can be found on a walk in a certain area
local walkItems =
{
    -- Short Walk: Sandoria
    [xi.zone.WEST_RONFAURE] =
    {
        xi.item.BEASTCOIN,
        xi.item.BRONZE_AXE,
        xi.item.RONFAURE_CHESTNUT,
        xi.item.FLINT_STONE,
        xi.item.CLUMP_OF_GARIDAV_WILDGRASS,
        xi.item.GOBLIN_MASK,
        xi.item.LITTLE_WORM,
        xi.item.PEBBLE,
        xi.item.SILVER_BEASTCOIN,
        xi.item.CLUMP_OF_TOKOPEKKO_WILDGRASS,
        xi.item.BAG_OF_WILDGRASS_SEEDS,
    },
    -- Short Walk: Bastok
    [xi.zone.NORTH_GUSTABERG] =
    {
        xi.item.BEASTCOIN,
        xi.item.FLINT_STONE,
        xi.item.CLUMP_OF_GARIDAV_WILDGRASS,
        xi.item.GOBLIN_MASK,
        xi.item.LITTLE_WORM,
        xi.item.EAR_OF_MILLIONCORN,
        xi.item.PEBBLE,
        xi.item.QUADAV_BACKPLATE,
        xi.item.SILVER_BEASTCOIN,
        xi.item.CLUMP_OF_TOKOPEKKO_WILDGRASS,
        xi.item.BAG_OF_WILDGRASS_SEEDS,
    },
    -- Short Walk: Windurst
    [xi.zone.EAST_SARUTABARUTA] =
    {
        xi.item.BEASTCOIN,
        xi.item.FLINT_STONE,
        xi.item.CLUMP_OF_GARIDAV_WILDGRASS,
        xi.item.GOBLIN_MASK,
        xi.item.GOBLIN_HELM,
        xi.item.LITTLE_WORM,
        xi.item.PEBBLE,
        xi.item.PIECE_OF_ROTTEN_MEAT,
        xi.item.SILVER_BEASTCOIN,
        xi.item.BOX_OF_TARUTARU_RICE,
        xi.item.CLUMP_OF_TOKOPEKKO_WILDGRASS,
        xi.item.BAG_OF_WILDGRASS_SEEDS,
        xi.item.YAGUDO_BEAD_NECKLACE,
    },
    -- Medium Walk: Sandoria
    [xi.zone.LA_THEINE_PLATEAU] =
    {
        xi.item.BEASTCOIN,
        xi.item.CRAB_SHELL,
        xi.item.CUPID_WORM,
        xi.item.CHUNK_OF_DARKSTEEL_ORE,
        xi.item.CLUMP_OF_GARIDAV_WILDGRASS,
        xi.item.GOBLIN_ARMOR,
        xi.item.LILAC,
        xi.item.PEBBLE,
        xi.item.SILVER_BEASTCOIN,
        xi.item.CLUMP_OF_TOKOPEKKO_WILDGRASS,
        xi.item.ZEGHAM_CARROT,
        xi.item.MYTHRIL_BEASTCOIN,
    },
    -- Medium Walk: Bastok
    [xi.zone.KONSCHTAT_HIGHLANDS] =
    {
        xi.item.BEASTCOIN,
        xi.item.CUPID_WORM,
        xi.item.CLUMP_OF_GARIDAV_WILDGRASS,
        xi.item.GOBLIN_ARMOR,
        xi.item.GOBLIN_HELM,
        xi.item.PEBBLE,
        xi.item.CHUNK_OF_DARKSTEEL_ORE,
        xi.item.CHUNK_OF_PLATINUM_ORE,
        xi.item.RAIN_LILY,
        xi.item.SHEEP_TOOTH,
        xi.item.SILVER_BEASTCOIN,
        xi.item.CLUMP_OF_TOKOPEKKO_WILDGRASS,
        xi.item.VOMP_CARROT,
        xi.item.ZEGHAM_CARROT,
    },
    -- Medium Walk: Windurst
    [xi.zone.TAHRONGI_CANYON] =
    {
        xi.item.AMARYLLIS,
        xi.item.BEASTCOIN,
        xi.item.CHICKEN_BONE,
        xi.item.CUPID_WORM,
        xi.item.CHUNK_OF_DARKSTEEL_ORE,
        xi.item.CLUMP_OF_GARIDAV_WILDGRASS,
        xi.item.GOBLIN_ARMOR,
        xi.item.PEBBLE,
        xi.item.CHUNK_OF_PLATINUM_ORE,
        xi.item.SILVER_BEASTCOIN,
        xi.item.VOMP_CARROT,
        xi.item.ZEGHAM_CARROT,
        xi.item.BAG_OF_TREE_CUTTINGS,
    },
    -- Long Walk: Sandoria
    [xi.zone.JUGNER_FOREST] =
    {
        xi.item.CHUNK_OF_ADAMAN_ORE,
        xi.item.GOBLIN_HELM,
        xi.item.GOLD_BEASTCOIN,
        xi.item.GREGARIOUS_WORM,
        xi.item.MYTHRIL_BEASTCOIN,
        xi.item.OLIVE_FLOWER,
        xi.item.CHUNK_OF_ORICHALCUM_ORE,
        xi.item.PEBBLE,
        xi.item.PIECE_OF_ROTTEN_MEAT,
        xi.item.SILVER_BEASTCOIN,
        xi.item.BAG_OF_TREE_CUTTINGS,
        xi.item.BAG_OF_WILDGRASS_SEEDS,
    },
    -- Long Walk: Bastok
    [xi.zone.PASHHOW_MARSHLANDS] =
    {
        xi.item.CHUNK_OF_ADAMAN_ORE,
        xi.item.CATTLEYA,
        xi.item.GOBLIN_HELM,
        xi.item.GREGARIOUS_WORM,
        xi.item.MYTHRIL_BEASTCOIN,
        xi.item.CHUNK_OF_ORICHALCUM_ORE,
        xi.item.PEBBLE,
        xi.item.PIECE_OF_ROTTEN_MEAT,
        xi.item.SILVER_BEASTCOIN,
        xi.item.BAG_OF_TREE_CUTTINGS,
    },
    -- Long Walk: Windurst
    [xi.zone.MERIPHATAUD_MOUNTAINS] =
    {
        xi.item.CHUNK_OF_ADAMAN_ORE,
        xi.item.CASABLANCA,
        xi.item.GOBLIN_HELM,
        xi.item.GOLD_BEASTCOIN,
        xi.item.GREGARIOUS_WORM,
        xi.item.MYTHRIL_BEASTCOIN,
        xi.item.PEBBLE,
        xi.item.PIECE_OF_ROTTEN_MEAT,
        xi.item.SILVER_BEASTCOIN,
        xi.item.BAG_OF_TREE_CUTTINGS,
        xi.item.CHUNK_OF_ORICHALCUM_ORE,
    },
}

-----------------------------------
-- Constants & Lookups
-----------------------------------

-- TODO: Remove the duplication for walk CSs
local csidTable =
{
    -- { intro csid, main csid, trading csid, rejection csid, chicks owner csid, short walk csid, medium walk csid, long walk csid, watch csid, debug }
    [xi.zone.SOUTHERN_SAN_DORIA] = { 817, 823, 826, 831, 852, 298, 299, 300, 304, 862 }, -- Hantileon
    [xi.zone.BASTOK_MINES]       = { 508, 509, 512, 515, 542, 554, 555, 556, 560, 558 }, -- Zopago
    [xi.zone.WINDURST_WOODS]     = { 741, 742, 745, 748, 766, 810, 811, 812, 816, 773 }, -- Pulonono
}

local raisingLocation =
{
    [xi.zone.SOUTHERN_SAN_DORIA] = 1,
    [xi.zone.BASTOK_MINES]       = 2,
    [xi.zone.WINDURST_WOODS]     = 3,
}

local shortWalkLocation =
{
    [1] = xi.zone.WEST_RONFAURE,
    [2] = xi.zone.NORTH_GUSTABERG,
    [3] = xi.zone.EAST_SARUTABARUTA,
}

local mediumWalkLocation =
{
    [1] = xi.zone.LA_THEINE_PLATEAU,
    [2] = xi.zone.KONSCHTAT_HIGHLANDS,
    [3] = xi.zone.TAHRONGI_CANYON,
}

local longWalkLocation =
{
    [1] = xi.zone.JUGNER_FOREST,
    [2] = xi.zone.PASHHOW_MARSHLANDS,
    [3] = xi.zone.MERIPHATAUD_MOUNTAINS,
}

local stage =
{
    EGG        = 1,
    CHICK      = 2,
    ADOLESCENT = 3,
    ADULT_1    = 4,
    ADULT_2    = 5,
    ADULT_3    = 6,
    ADULT_4    = 7, -- Retired?
}

local color =
{
    YELLOW = 0,
    BLACK  = 1,
    BLUE   = 2,
    RED    = 3,
    GREEN  = 4,
}

local sex =
{
    MALE   = 0,
    FEMALE = 1,
}
utils.unused(sex)

local abilities =
{
    NONE            = 0,
    GALLOP          = 1,
    CANTER          = 2,
    BURROW          = 3,
    BORE            = 4,
    AUTO_REGEN      = 5,
    TREASURE_FINDER = 6,
}
utils.unused(abilities)

local personality =
{
    EASYGOING    = 0,
    ILL_TEMPERED = 1,
    PATIENT      = 2,
    SENSITIVE    = 3,
    ENIGMATIC    = 4,
}
utils.unused(personality)

-- NOTE: Dislikes are just the next weather in the cycle after the likes
local weather =
{
    CLEAR_DAYS = 0,
    HOT_DAYS   = 1,
    RAINY_DAYS = 2,
    SANDSTORMS = 3,
    WINDY      = 4,
    SNOW       = 5,
    THUNDER    = 6,
    AURORAS    = 7,
    DARK       = 8,
}
utils.unused(weather)

local affectionRank =
{
    DOESNT_CARE       = 0,
    CAN_ENDURE        = 1,
    SLIGHTLY_ENJOY    = 2,
    LIKES             = 3,
    LIKES_PRETTY_WELL = 4,
    LIKES_A_LOT       = 5,
    ALL_THE_TIME      = 6,
    PARENT            = 7,
}
utils.unused(affectionRank)

local hunger =
{
    STARVING        = 0,
    QUITE_HUNGRY    = 1,
    A_LITTLE_HUNGRY = 2,
    AVERAGE_1       = 3,
    AVERAGE_2       = 4,
    ALMOST_FULL     = 5,
    QUITE_FULL      = 6,
    COMPLETELY_FULL = 7,
}
utils.unused(hunger)

-- TODO: Combine carePlanData with this cutscenes table, so cutscenes have associated
--     : stat changes that can be looked up and applied.
local cutscenes =
{
    -- Each cutscene needs this offset added to them before they can be used,
    -- depending on the zone
    SANDORIA_OFFSET = 256,
    BASTOK_OFFSET   = 512,
    WINDURST_OFFSET = 768,

    -- EGG ONWARDS:
    REPORT_BASIC_CARE = 0,

    -- CHICK ONWARDS:
    REPORT_REST            = 1,
    REPORT_TAKE_A_WALK     = 2,
    REPORT_LISTEN_TO_MUSIC = 3,

    -- ADOLESCENT ONWARDS:
    REPORT_EXERCISE_ALONE         = 4,
    REPORT_EXERCISE_IN_A_GROUP    = 5,
    REPORT_INTERACT_WITH_CHILDREN = 6,
    REPORT_INTERACT_WITH_CHOCOBOS = 7,
    REPORT_CARRY_PACKAGES         = 8,
    REPORT_EXHIBIT_TO_THE_PUBLIC  = 9,

    -- ADULT ONWARDS:
    REPORT_DELIVER_MESSAGES = 10,
    REPORT_DIG_FOR_TREASURE = 11,
    REPORT_ACT_IN_A_PLAY    = 12,

    -- OTHER:
    EGG_HATCHING          = 33,
    CHICK_TO_ADOLESCENT   = 34,
    ADOLESCENT_TO_ADULT_1 = 35,
    ADULT_1_TO_ADULT_2    = 36,
    ADULT_2_TO_ADULT_3    = 37,
    ADULT_3_TO_ADULT_4    = 38,

    RAN_AWAY = 39,
    -- 40: Player gives the chocobo x
    -- 48: Happy to see you
    INTERESTED_IN_YOUR_STORY = 50,
    HANGS_HEAD_IN_SHAME      = 51, -- Hangs its head in shame
    COMPETE_WITH_OTHERS      = 52,
    HAVENT_SEEN_YOU          = 53, -- Haven't seen you around, chocobo is sleeping (dispose of white handkerchief)
    -- 54: Accept white handkerchief
    CRYING_AT_NIGHT = 69, -- White handkerchief
    -- 70: Chocobo full of energy!
    -- 71: Bright and focused
    -- 72: Injury has healed
    CALMED_DOWN = 77,
    -- 84: Sleeping well thanks to White Handkerchief
}

local getCutsceneWithOffset = function(player, cutscene)
    local cutsceneOffsets =
    {
        [xi.zone.SOUTHERN_SAN_DORIA] = cutscenes.SANDORIA_OFFSET,
        [xi.zone.BASTOK_MINES]       = cutscenes.BASTOK_OFFSET,
        [xi.zone.WINDURST_WOODS]     = cutscenes.WINDURST_OFFSET,
    }

    return cutscene + cutsceneOffsets[player:getZoneID()]
end

xi.chocoboRaising.newChocobo = function(player, egg)
    local newChoco = {}

    -- TODO: If egg exdata is empty (historic objects, etc.) then generate it randomly now.
    --     : Otherwise, extract the exdata for use.
    -- local exData = egg:getExData();

    --[[
        https://github.com/Ivaar/Windower-addons/blob/master/chococard/chococard.lua

        plan        = {[0]='A','B','C','D'},
        gender      = {[0]='Male','Female'},
        color       = {[0]='Yellow','Black','Blue','Red','Green'},
        ability     = {[0]='None','Gallop','Canter','Burrow','Bore','Auto-Regen','Treasure Finder'},

        fields.egg = {
            DNA         = {'b3b3b3', 0x00+1,        fn=map_fields+{'color'}},
            ability     = {'b4',     0x01+1, 1+1},
            unknown1    = {'b1',     0x01+1, 5+1},
            plan        = {'b2',     0x01+1, 6+1},
            unknown2    = {'b15',    0x02+1},
            is_bred     = {'q',      0x03+1, 7+1},
        }

        Egg exData from Dabih Jajalioh (CHOCOBO_EGG_FAINTLY_WARM: 2312):
        00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00

        Egg exData from breeder:(CHOCOBO_EGG_A_BIT_WARM: 2317)

        8C C0 00 80 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00

        8C: 1000 1100
        C0: 1100 0000
        00: 0000 0000
        80: 1000 0000

        Plan: D
        DNA: [Green, Black, Blue]
        Ability: None
    ]]

    newChoco.first_name      = 'Chocobo'
    newChoco.last_name       = 'Chocobo'
    newChoco.sex             = math.ceil(math.random() - 0.5) -- Random 0 or 1
    newChoco.created         = GetSystemTime()
    newChoco.age             = 0
    newChoco.last_update_age = 1
    newChoco.stage           = stage.EGG
    newChoco.location        = raisingLocation[player:getZoneID()]

    -- TODO: Random genes, or take from egg
    newChoco.dominant_gene  = 0 -- TODO
    newChoco.recessive_gene = 0 -- TODO

    -- TODO: Pick various stats based on genetics
    newChoco.color             = color.YELLOW
    newChoco.strength           = 0
    newChoco.endurance          = 0
    newChoco.discernment        = 0
    newChoco.receptivity        = 0
    newChoco.affection          = 255
    newChoco.energy             = 100
    newChoco.satisfaction       = 0
    newChoco.conditions         = 0
    newChoco.ability1           = 0
    newChoco.ability2           = 0
    newChoco.personality        = 0
    newChoco.weather_preference = 0
    newChoco.hunger             = 0

    -- NOTE: We store the care plans in-order as 4x 8-bit values:
    -- The first 4 bits are the length of the plan
    -- The last 4 bits are the type of the plan
    local defaultCarePlan = bit.lshift(7, 4) + 0
    newChoco.care_plan =
        bit.lshift(defaultCarePlan, 24) +
        bit.lshift(defaultCarePlan, 16) +
        bit.lshift(defaultCarePlan,  8) +
        bit.lshift(defaultCarePlan,  0)

    newChoco.held_item = 0

    return newChoco
end

local packStats1 = function(chocoState)
    return bit.lshift(chocoState.strength,     0) +
        bit.lshift(chocoState.endurance,    8) +
        bit.lshift(chocoState.discernment, 16) +
        bit.lshift(chocoState.receptivity, 24)
end

local packStats2 = function(chocoState)
    return bit.lshift(chocoState.affection,     0) +
        bit.lshift(chocoState.energy,        8) +
        bit.lshift(chocoState.satisfaction, 16)
end

local getWeatherInZone = function(zoneId)
    local zone = GetZone(zoneId)

    if not zone then
        print('ChocoboRaising: Failed to get Zone object for weather information. \
            Is the target zone on another executable?')
        return xi.weather.NONE
    end

    return zone:getWeather()
end

-- If stage = [1] and age >= [2], play CS: [3] and set stage to [4].
local ageBoundaries =
{
    { stage.EGG,        xi.chocoboRaising.daysToChick,      cutscenes.EGG_HATCHING,          stage.CHICK },
    { stage.CHICK,      xi.chocoboRaising.daysToAdolescent, cutscenes.CHICK_TO_ADOLESCENT,   stage.ADOLESCENT },
    { stage.ADOLESCENT, xi.chocoboRaising.daysToAdult1,     cutscenes.ADOLESCENT_TO_ADULT_1, stage.ADULT_1 },
    { stage.ADULT_1,    xi.chocoboRaising.daysToAdult2,     cutscenes.ADULT_1_TO_ADULT_2,    stage.ADULT_2 },
    { stage.ADULT_2,    xi.chocoboRaising.daysToAdult3,     cutscenes.ADULT_2_TO_ADULT_3,    stage.ADULT_3 },
    { stage.ADULT_3,    xi.chocoboRaising.daysToAdult4,     cutscenes.ADULT_3_TO_ADULT_4,    stage.ADULT_4 },
}

local ageToStage = function(age)
    for _, entry in pairs(ageBoundaries) do
        if age <= entry[2] then
            return entry[1]
        end
    end

    return stage.ADULT_4
end

local compareTables = function(t1, t2)
    if
        not t1 or
        not t2
    then
        return false
    end

    if type(t1) ~= 'table' then
        return false
    end

    if type(t2) ~= 'table' then
        return false
    end

    if #t1 ~= #t2 then
        return false
    end

    for idx, val1 in pairs(t1) do
        local val2 = t2[idx]

        if val1 ~= val2 then
            return false
        end
    end

    return true
end

-- NOTE: This is playable, but not quite right.
-- Day1-4 should be condensed together, with the
-- hatching CS playing at the end.
-- Currently this outputs:
-- Day1-4: Basic care
-- Day 4: Hatching CS
-- Day 5-onwards: As normal
-- It should output:
-- Day1-4: Basic care, then hatching CS
-- Day5-onwards: As normal
local condenseEvents = function(player, chocoState, events)
    local cutEvent = function(t, eStart, eEnd, csList)
        table.insert(t, { eStart, eEnd, csList })
    end

    local condensedEvents     = {}
    local currentStartDay     = nil
    local currentEndDay       = nil
    local currentEventCSTable = nil

    -- Each event is a table of cs's
    debug('Raw Events')
    for _, entry in pairs(events) do
        debug('Day', entry[1], ':', entry[2][1])
        -- Only condense days with the same table contents
        if compareTables(entry[2], currentEventCSTable) then
            -- Increase the span
            currentEndDay = currentEndDay + 1
        else
            -- If there is an active span, cut it now
            if currentEventCSTable then
                cutEvent(condensedEvents, currentStartDay, currentEndDay, currentEventCSTable)
            end

            -- Start a new span
            currentEventCSTable = entry[2]
            currentStartDay     = entry[1]
            currentEndDay       = entry[1]
        end
    end

    -- Final 'cut'
    cutEvent(condensedEvents, currentStartDay, currentEndDay, currentEventCSTable)

    debug('Condensed Events & Spans')
    for _, entry in pairs(condensedEvents) do
        debug('Days', entry[1], 'to', entry[2], ':', entry[3][1])
    end

    return condensedEvents
end

local updateChocoState = function(player, chocoState)
    -- Update age and last_update_age
    chocoState.age             = math.floor((GetSystemTime() - chocoState.created) / xi.chocoboRaising.dayLength) + 1
    chocoState.last_update_age = chocoState.age

    debug(string.format('Writing chocoState to cache and db. age: %d, last_update_age: %d', chocoState.age, chocoState.last_update_age))

    -- Write to cache
    xi.chocoboRaising.chocoState[player:getID()] = chocoState

    -- Write to db
    player:setChocoboRaisingInfo(chocoState)

    return chocoState
end

local onRaisingEventPlayout = function(player, csOffset, chocoState)
    switch (csOffset): caseof
    {
        -- EGG ONWARDS:
        [cutscenes.REPORT_BASIC_CARE] = function()
            handleCarePlan(player, chocoState, carePlans.BASIC_CARE)
        end,

        -- CHICK ONWARDS:
        [cutscenes.REPORT_REST] = function()
            handleCarePlan(player, chocoState, carePlans.RESTING)
        end,

        [cutscenes.REPORT_TAKE_A_WALK] = function()
            handleCarePlan(player, chocoState, carePlans.TAKING_A_WALK)
        end,

        [cutscenes.REPORT_LISTEN_TO_MUSIC] = function()
            handleCarePlan(player, chocoState, carePlans.LISTENING_TO_MUSIC)
        end,

        -- ADOLESCENT ONWARDS:
        [cutscenes.REPORT_EXERCISE_ALONE] = function()
            handleCarePlan(player, chocoState, carePlans.EXERCISING_ALONE)
        end,

        [cutscenes.REPORT_EXERCISE_IN_A_GROUP] = function()
            handleCarePlan(player, chocoState, carePlans.EXCERCISING_IN_A_GROUP)
        end,

        [cutscenes.REPORT_INTERACT_WITH_CHILDREN] = function()
            handleCarePlan(player, chocoState, carePlans.PLAYING_WITH_CHILDREN)
        end,

        [cutscenes.REPORT_INTERACT_WITH_CHOCOBOS] = function()
            handleCarePlan(player, chocoState, carePlans.PLAYING_WITH_CHOCOBOS)
        end,

        [cutscenes.REPORT_CARRY_PACKAGES] = function()
            handleCarePlan(player, chocoState, carePlans.CARRYING_PACKAGES)
        end,

        [cutscenes.REPORT_EXHIBIT_TO_THE_PUBLIC] = function()
            handleCarePlan(player, chocoState, carePlans.EXHIBITING_TO_THE_PUBLIC)
        end,

        -- ADULT ONWARDS:
        [cutscenes.REPORT_DELIVER_MESSAGES] = function()
            handleCarePlan(player, chocoState, carePlans.DELIVERING_MESSAGES)
        end,

        [cutscenes.REPORT_DIG_FOR_TREASURE] = function()
            handleCarePlan(player, chocoState, carePlans.DIGGING_FOR_TREASURE)
        end,

        [cutscenes.REPORT_ACT_IN_A_PLAY] = function()
            handleCarePlan(player, chocoState, carePlans.ACTING_IN_A_PLAY)
        end,

        -- Growth CSs
        [cutscenes.ADULT_2_TO_ADULT_3] = function()
            -- You waited too long to name your chocobo, trainer is going to do it for you!
            if
                chocoState.first_name == 'Chocobo' and
                chocoState.last_name == 'Chocobo'
            then
                -- Pick a name at random: First name only
                chocoState.first_name = xi.chocoboNames.getRandomName()
                chocoState.last_name = ''
            end
        end,

        [cutscenes.CRYING_AT_NIGHT] = function()
            -- NOTE: The messaging is handled in the CS
            player:addKeyItem(xi.ki.WHITE_HANDKERCHIEF)
            player:setCharVar('[choco]WH_TIME', GetSystemTime() * utils.days(1))
        end,

        [cutscenes.HAVENT_SEEN_YOU] = function()
            player:delKeyItem(xi.ki.WHITE_HANDKERCHIEF)
            player:setCharVar('[choco]WH_TIME', 0)
        end,

        [cutscenes.HANGS_HEAD_IN_SHAME] = function()
            -- TODO: Take in a multiplier to account for merged time ranges
            chocoState.affection = handleStatChange(chocoState.affection, -10, 255)
            chocoState.energy    = handleStatChange(chocoState.energy, -5, 100)
            setCondition(chocoState, conditions.SPOILED, false)
        end,

        [cutscenes.COMPETE_WITH_OTHERS] = function()
            -- TODO: Take in a multiplier to account for merged time ranges
            -- 'Increases affection slightly - confirmed.'
            chocoState.affection = handleStatChange(chocoState.affection, 1, 255)
            chocoState.energy    = handleStatChange(chocoState.energy, -5, 100)
            setCondition(chocoState, conditions.BORED, false)
        end,
    }

    updateChocoState(player, chocoState)

    return chocoState
end

local handleCSUpdate = function(player, chocoState, doEventUpdate)
    -- Generate final CS value from (location offset * 256) + cutscene offset
    local csOffset       = chocoState.csList[1]
    local locationOffset = raisingLocation[player:getZoneID()] * 256
    local csToPlay       = locationOffset + csOffset

    debug('Playing CS: ' .. csToPlay .. ' (' .. csOffset .. ')')
    table.remove(chocoState.csList, 1)

    local currentAgeOfChocoboDuringCutscene = 0

    -- TODO: Move this into initData
    if csOffset == cutscenes.EGG_HATCHING then
        chocoState.stage = stage.CHICK
    elseif csOffset == cutscenes.CHICK_TO_ADOLESCENT then
        chocoState.stage = stage.ADOLESCENT
    elseif csOffset == cutscenes.ADOLESCENT_TO_ADULT_1 then
        chocoState.stage = stage.ADULT_1
    elseif csOffset == cutscenes.ADULT_1_TO_ADULT_2 then
        chocoState.stage = stage.ADULT_2
    elseif csOffset == cutscenes.ADULT_2_TO_ADULT_3 then
        chocoState.stage = stage.ADULT_3
    elseif csOffset == cutscenes.ADULT_3_TO_ADULT_4 then
        chocoState.stage = stage.ADULT_4
    end

    chocoState = onRaisingEventPlayout(player, csOffset, chocoState)

    -- Skip the event updates during 'Skip Report'
    if doEventUpdate then
        player:updateEventString(chocoState.first_name, chocoState.last_name, chocoState.first_name, chocoState.first_name,
            0, 0, 0, 0, 0, 0, 0, 0)
        player:updateEvent(#chocoState.csList, csToPlay, 0, chocoState.color, chocoState.stage, 0, currentAgeOfChocoboDuringCutscene, 1)
    end

    return chocoState
end

xi.chocoboRaising.initChocoboData = function(player)
    local chocoState = player:getChocoboRaisingInfo()
    if not chocoState then
        return chocoState
    end

    -- Generate data that doesn't need to be persisted to the db
    -- but is needed at runtime

    -- Work out ranks, age, and stages from raw information

    -- Age is worked out alongside 'the day you handed in your egg'
    -- So on the 0th day, the chocobo is 1 day old.

    chocoState.age = math.floor((GetSystemTime() - chocoState.created) / xi.chocoboRaising.dayLength) + 1

    debug('chocoState.age = ' .. chocoState.age)
    debug('chocoState.last_update_age = ' .. chocoState.last_update_age)

    chocoState.affectionRank = affectionRank.LIKES

    -- Add helpers and empty tables to navigate CSs
    chocoState.csList        = {}
    chocoState.foodGiven     = {}
    chocoState.report        = {}
    chocoState.report.events = {}

    -- Step 1: Determine if enough time has passed to show a report (n > 0 day)

    -- No need to generate a report, bail out!
    if chocoState.age - chocoState.last_update_age <= 0 then
        chocoState.last_update_age = chocoState.age

        return chocoState
    end

    chocoState.report.day_start = chocoState.last_update_age
    chocoState.report.day_end   = chocoState.age
    local reportLength          = chocoState.report.day_end - chocoState.report.day_start

    debug('reportLength', reportLength)

    chocoState.last_update_age = chocoState.age

    -- Step 2: Build a table of every event that happened on every day
    -- Example: If the reporting period is Day1-Day10, the table will
    -- contain _at least_ 10 entries - one for every day, plus others.
    -- TODO: Each event needs to know the age and stage of the chocobo at that day
    local events = {}

    local plan1Length = bit.rshift(bit.band(chocoState.care_plan, 0xF0000000), 28)
    local plan1Type   = bit.rshift(bit.band(chocoState.care_plan, 0x0F000000), 24)
    local plan2Length = bit.rshift(bit.band(chocoState.care_plan, 0x00F00000), 20)
    local plan2Type   = bit.rshift(bit.band(chocoState.care_plan, 0x000F0000), 16)
    local plan3Length = bit.rshift(bit.band(chocoState.care_plan, 0x0000F000), 12)
    local plan3Type   = bit.rshift(bit.band(chocoState.care_plan, 0x00000F00),  8)
    local plan4Length = bit.rshift(bit.band(chocoState.care_plan, 0x000000F0),  4)
    local plan4Type   = bit.rshift(bit.band(chocoState.care_plan, 0x0000000F),  0)

    local possibleCarePlanFuture = {}

    for _ = 1, plan1Length do
        table.insert(possibleCarePlanFuture, plan1Type)
    end

    for _ = 1, plan2Length do
        table.insert(possibleCarePlanFuture, plan2Type)
    end

    for _ = 1, plan3Length do
        table.insert(possibleCarePlanFuture, plan3Type)
    end

    for _ = 1, plan4Length do
        table.insert(possibleCarePlanFuture, plan4Type)
    end

    -- TODO: Remove careplan energy from this
    chocoState.energy = 100

    for idx = 1, reportLength do
        local possibleCarePlanEvent = possibleCarePlanFuture[idx]

        if possibleCarePlanEvent == nil then -- We went past the end of the care plan
            possibleCarePlanEvent = 0 -- Default to Basic Care
        end

        local age          = chocoState.report.day_start + idx - 1
        local currentStage = ageToStage(age)
        local event        = { age, { possibleCarePlanEvent } }

        table.insert(events, event)

        -- If the chocobo doesn't have any conditions, roll to see if they get one
        if not hasCondition(chocoState) then
            for _, condition in pairs(conditions) do
                -- TODO: Use stats and history instead of pure chance to see what
                --     : conditions might happen
                if math.random(1, 100) <= 5 then
                    setCondition(chocoState, condition, true)
                    break
                end
            end
        end

        -- For each condition, if chocobo has that condition, play
        -- out relevant CS.
        for _, condition in pairs(conditions) do
            if getCondition(chocoState, condition) then
                -- TODO: Mark that we've played this CS today so we don't immediately resolve it
                utils.unused()
            end
        end

        -- TODO: For each condition that the chocobo has, if they haven't JUST
        --     : had the CS play for it, roll 50% to see if it resolved on its own.

        -- Handle age-up cs's
        for _, entry in pairs(ageBoundaries) do
            if currentStage == entry[1] and age >= entry[2] then
                table.insert(events, { age, { entry[3] } })
            end
        end

        -- Start White Handkerchief quest
        local whiteHandkerchiefStarted = false
        if
            -- TODO: Should this be a charvar to track this?
            not player:hasKeyItem(xi.ki.WHITE_HANDKERCHIEF) and
            age == 7
        then
            table.insert(events, { age, { cutscenes.CRYING_AT_NIGHT } })
            whiteHandkerchiefStarted = true
        end

        -- Cancel White Handkerchief quest
        if
            whiteHandkerchiefStarted and
            age == 15 and
            reportLength >= 7
        then
            table.insert(events, { age, { cutscenes.HAVENT_SEEN_YOU } })
        end

        -- TODO: Remove used days from care plan and write back to chocoState + db
    end

    -- Step 3: Condense that table down
    -- Step 4: Assign this report to the cache
    chocoState.report.events = condenseEvents(player, chocoState, events)

    return chocoState
end

xi.chocoboRaising.startCutscene = function(player, npc, trade)
    local ID            = zones[player:getZoneID()]
    local reminderCsid  = csidTable[player:getZoneID()][1]
    local mainCsid      = csidTable[player:getZoneID()][2]
    local tradeCsid     = csidTable[player:getZoneID()][3]
    local rejectionCsid = csidTable[player:getZoneID()][4]
    local chocoState    = xi.chocoboRaising.initChocoboData(player)

    if chocoState == nil then
        print('ERROR! startCutscene \'chocoState\' is nil!')

        return
    end

    if trade then -- Trade
        if
            npcUtil.tradeHasExactly(trade, xi.item.CHOCOBO_EGG_FAINTLY_WARM) or
            npcUtil.tradeHasExactly(trade, xi.item.CHOCOBO_EGG_SLIGHTLY_WARM) or
            npcUtil.tradeHasExactly(trade, xi.item.CHOCOBO_EGG_A_BIT_WARM) or
            npcUtil.tradeHasExactly(trade, xi.item.CHOCOBO_EGG_A_LITTLE_WARM) or
            npcUtil.tradeHasExactly(trade, xi.item.CHOCOBO_EGG_SOMEWHAT_WARM)
        then
            if chocoState == nil then
                -- Handed over egg, handled in onEventFinish and xi.chocoboRaising.newChocobo
                player:startEvent(tradeCsid, 0, 0, 0, 0, 0, 0, 0, 1)
            else -- Already has a chocobo
                -- Check location
                if chocoState.location ~= raisingLocation[player:getZoneID()] then
                    player:startEvent(rejectionCsid, 1)
                else
                    player:startEvent(rejectionCsid, 0)
                end
            end

            return
        end

        -- TODO: Confirm this on retail
        -- 'Your chocobo has not hatched, so you cannot feed it yet.'
        if chocoState.stage == stage.EGG then
            player:messageSpecial(ID.text.CHOCOBO_FEEDING_STILL_EGG)
            return
        end

        -- Validate traded items
        local tradedItems = {}

        for slotId = 0, 7 do
            local item = trade:getItem(slotId)

            if item then
                local id = item:getID()
                -- Invalid foods are skipped and valid foods are accepted
                if validFoods[id] then
                    local quantity = trade:getSlotQty(slotId)

                    for _ = 1, quantity do
                        table.insert(tradedItems, id)
                    end

                    trade:confirmItem(id, quantity)
                end
            end
        end

        if #tradedItems > 0 then
            chocoState.foodGiven = tradedItems
        end
    else -- Trigger
        -- Trade an egg to me if you want to start raising a chocobo.
        if chocoState == nil then
            player:startEvent(reminderCsid, 1)
            return
        else
            -- Check location
            if chocoState.location ~= raisingLocation[player:getZoneID()] then
                player:startEvent(reminderCsid, 1, 1, 1, 1)

                return
            end
        end
    end

    local isTradeEvent = 0

    if #chocoState.foodGiven > 0 then
        isTradeEvent = 8
    end

    -- 0: Hello, x. What brings you here today?
    -- 1: Hello, x. I have some information to relay to you regarding your egg.
    local infoFlag = 0

    if #chocoState.report.events > 0 then
        infoFlag = 1
    end

    -- Now that we're done modifiying it, write chocoState to cache
    xi.chocoboRaising.chocoState[player:getID()] = chocoState

    player:startEventString(mainCsid, chocoState.first_name, chocoState.last_name, chocoState.first_name, chocoState.last_name,
        isTradeEvent, infoFlag, chocoState.sex, 0, 0, 0, 0, 0)
end

-----------------------------------
-- VCS Trainer Interactions
-----------------------------------

xi.chocoboRaising.onTradeVCSTrainer = function(player, npc, trade)
    if not xi.settings.main.ENABLE_CHOCOBO_RAISING then
        player:startEvent(csidTable[player:getZoneID()][1])

        return
    end

    xi.chocoboRaising.startCutscene(player, npc, trade)
end

xi.chocoboRaising.onTriggerVCSTrainer = function(player, npc)
    if not xi.settings.main.ENABLE_CHOCOBO_RAISING then
        player:startEvent(csidTable[player:getZoneID()][1])

        return
    end

    xi.chocoboRaising.startCutscene(player, npc, nil)
end

xi.chocoboRaising.onEventUpdateVCSTrainer = function(player, csid, option, npc)
    if not xi.settings.main.ENABLE_CHOCOBO_RAISING then
        return
    end

    -- TODO: The majority of logic is controlled by the option, which is
    -- sent in by the client. We can't trust this isn't tampered with.
    -- We shouldtrack which options are valid at which time.

    local ID         = zones[player:getZoneID()]
    local mainCsid   = csidTable[player:getZoneID()][2]
    local tradeCsid  = csidTable[player:getZoneID()][3]
    local chocoState = xi.chocoboRaising.chocoState[player:getID()]

    -- Egg trade
    if csid == tradeCsid then
        if option == 252 then
            player:updateEvent(0, raisingLocation[player:getZoneID()], 0, 0, 0, 0, 0, 0)
        end

    -- Egg check
    elseif csid == mainCsid then
        if chocoState == nil then
            print('ERROR! onEventUpdateVCSTrainer \'chocoState\' is nil!')

            return
        end

        debug(string.format('CS Update: %i', option))

        -- Setting the name for a chocobo: when the name is
        -- applied from the menu the name offsets (from the menu)
        -- are sent combined inside the option. The bottom byte
        -- of the option is filled as below:
        -- (Name offsets are 10-bits wide)
        --
        -- 0000 0000 0000 0100 0000 0000 1111 1111
        --      ^----------^^----------^ ^-------^
        --       last_name   first_name   name_change_flag (0xFF)

        if bit.band(0x000000FF, option) == 0xFF then
            local offset1     = bit.band(0x3FF, bit.rshift(option, 8))
            local offset2     = bit.band(0x3FF, bit.rshift(option, 18))
            local fname       = xi.chocoboNames[offset1]
            local lname       = xi.chocoboNames[offset2]
            local fullnamekey = string.format('%s %s', fname, lname)

            -- https://ffxiclopedia.fandom.com/wiki/Chocobo_Names
            -- '... with the caveat that your chocobo's name may be no more than 15 letters in total.'
            -- NOTE: This is enforced by the client, this is here to stop malicious naming attempts
            local nameTooLong = string.len(fullnamekey) > (15 + 1) -- 15 + the space character

            -- If renaming fails, the name will remain as 'Chocobo Chocobo' and the
            -- rejection CS will play
            if not fname or not lname then
                print('ERROR! onEventUpdateVCSTrainer - chocoboNames lookup failed!')
            elseif nameTooLong then
                print(string.format('ERROR! %s selected name combination too long for chocobo: %s', player:getName(), fullnamekey))
            elseif xi.bannedChocoboNames[fullnamekey] then
                print(string.format('ERROR! %s selected banned name for chocobo: %s', player:getName(), fullnamekey))
            else
                chocoState.first_name = fname
                chocoState.last_name  = lname

                debug(string.format('%s updating chocobo name: %s', player:getName(), fullnamekey))

                -- Write to cache
                xi.chocoboRaising.chocoState[player:getID()] = chocoState

                -- Set synthetic CS option for later CSs
                option = 0xFF
                debug(string.format('CS (Synthetic) Update: %i', option))
            end
        end

        -- Similar to above, updates to care plan are flagged by setting bits
        -- in the update option. In this case, the mask if 0xFE (1111 1110).
        --
        -- Plan 1, basic care, 7 days
        -- 459006
        -- 0000 0000 0000 0111 0000 0000 1111 1110
        --            ^---^^-^      ^--^ ^-------^
        --             1    2        3    4
        --
        -- 1: Length of care plan
        -- 2: Type of care plan
        -- 3: Slot of care plan
        -- 4: 'Key' for care plan updates (0xFE)

        if bit.band(0x000000FF, option) == 0xFE then
            local carePlanSlot   = bit.band(0xF, bit.rshift(option, 8))
            local carePlanLength = bit.band(0x7, bit.rshift(option, 16))
            local carePlanType   = bit.band(0xF, bit.rshift(option, 19))

            -- If zero, make sure to default
            if chocoState.care_plan == 0 then
                local defaultCarePlan = bit.lshift(7, 4) + 0

                chocoState.care_plan =
                    bit.lshift(defaultCarePlan, 24) +
                    bit.lshift(defaultCarePlan, 16) +
                    bit.lshift(defaultCarePlan,  8) +
                    bit.lshift(defaultCarePlan,  0)
            end

            local carePlan = bit.lshift(carePlanLength, 4) + carePlanType

            -- Zero out the target slot
            local targetSlotOffset = 24 - (carePlanSlot * 8)
            local mask             = bit.bnot(bit.lshift(0xFF, targetSlotOffset))
            local zerodCarePlan    = bit.band(chocoState.care_plan, mask)

            -- Then write the new care plan to it
            local finalCarePlan  = bit.bor(zerodCarePlan, bit.lshift(carePlan, targetSlotOffset))
            chocoState.care_plan = finalCarePlan

            print(string.format('%s updating chocobo care plan: slot: %i type: %i length: %i',
                player:getName(), carePlanSlot + 1, carePlanType, carePlanLength))

            -- Write to cache
            xi.chocoboRaising.chocoState[player:getID()] = chocoState
        end

        --------------------------------------------------------
        -- Main body update logic
        --------------------------------------------------------
        switch (option): caseof
        {
            -- ?
            [208] = function()
                local hasReport = 0
                if #chocoState.report.events > 0 then
                    hasReport = 0xFFFFFFFF
                end

                player:updateEvent(hasReport, 0, 0, 0, chocoState.stage, 0, 0, 0)
            end,

            -- ?
            [252] = function()
                local hasReport = 0
                if #chocoState.report.events > 0 then
                    hasReport = 0xFFFFFFFF
                end

                player:updateEvent(hasReport, 1, 1, 1, chocoState.stage, 1, 1, 1)
            end,

            -- Main menu (248 -> 214 -> 215)
            -- Update (248 -> 246 -> 244)
            [248] = function()
                local report = 0x00000000

                if #chocoState.report.events > 0 then
                    -- Pop the event from the front of the list
                    local currentEvent = chocoState.report.events[1]
                    table.remove(chocoState.report.events, 1)

                    local eventStartStart = currentEvent[1]
                    local eventStartEnd   = currentEvent[2]
                    local eventCSList     = currentEvent[3]

                    chocoState.age   = eventStartStart
                    chocoState.stage = ageToStage(chocoState.age)

                    for _, cs in pairs(eventCSList) do
                        table.insert(chocoState.csList, cs)
                    end

                    report = bit.lshift(eventStartStart, 0) + bit.lshift(eventStartEnd, 20)

                    if eventStartStart == eventStartEnd then
                        -- Single day update
                        report = report + 0x00000400
                    else
                        -- Multi-day update
                        report = report + 0x00001000
                    end
                end

                local playMultipleCutscenes = 0

                if #chocoState.report.events > 0 then
                    report = report + 0x80000000
                    playMultipleCutscenes = 0x00010000
                end

                local exitFlag = 0

                player:updateEvent(248, report, #chocoState.csList, playMultipleCutscenes, chocoState.stage, 0, 0, exitFlag)
            end,

            [214] = function()
                player:updateEvent(0, 0, 0, 0, 0, 0, 0, 0)
            end,

            [215] = function()
                -- Define menu options
                -- bit.lshift(0x01, 0): Ask about your chocobo's condition
                local askAboutChocoboCondition = -bit.lshift(0x01, 0)

                -- bit.lshift(0x01, 1): Care for your chocobo
                local careForYourChocobo = -bit.lshift(0x01, 1)

                -- Set up a care schedule
                local setUpCareSchedule = -bit.lshift(0x01, 2)
                local nameChocobo       = 0

                if
                    chocoState.stage > stage.EGG and
                    chocoState.first_name == 'Chocobo' and
                    chocoState.last_name == 'Chocobo'
                then
                    nameChocobo = -bit.lshift(0x01, 3) -- Name your chocobo
                end

                -- bit.lshift(0x01, 4): Request Documentation
                -- bit.lshift(0x01, 5): Register to call your chocobo
                -- bit.lshift(0x01, 6): Receive your chocobo whistle
                -- bit.lshift(0x01, 7): Purchase a chocobo whistle

                -- 8 - 25 are all '-----' (blank)

                -- Go forward 1 unit (debug) (Unused, see command: !chocoboraising)
                local goForward1UnitDebug = -bit.lshift(0x01, 26)
                utils.unused(goForward1UnitDebug)

                -- Abilities print (debug) (Unused, see command: !chocoboraising)
                local abilitiesPrintDebug = -bit.lshift(0x01, 27)
                utils.unused(abilitiesPrintDebug)

                -- User work print (debug) (Unused, see command: !chocoboraising)
                local userWorkPrintDebug = -bit.lshift(0x01, 28)
                utils.unused(userWorkPrintDebug)

                local retireOrGiveUp = 0
                if chocoState.stage < stage.ADULT_1 then
                    retireOrGiveUp = -bit.lshift(0x01, 30) -- Give up chocobo raising
                else
                    retireOrGiveUp = -bit.lshift(0x01, 29) -- Retire your chocobo
                end

                -- bit.lshift(0x01, 31): Nothing. (exit)
                local exit = -bit.lshift(0x01, 31)

                -- Enable menu options (remove bits from 0xFFFFFFFF)
                local menuFlags = 0xFFFFFFFF +
                    askAboutChocoboCondition +
                    careForYourChocobo +
                    setUpCareSchedule +
                    nameChocobo +
                    retireOrGiveUp

                if chocoState.stage >= stage.CHICK then
                    utils.unused()
                    --menuFlags = menuFlags
                end

                if chocoState.stage >= stage.ADOLESCENT then
                    utils.unused()
                    -- menuFlags = menuFlags
                end

                if chocoState.stage >= stage.ADULT_1 then
                    utils.unused()
                    -- menuFlags = menuFlags
                end

                -- Exit is always available
                menuFlags = menuFlags + exit

                player:updateEvent(menuFlags, 0, 0, 0, 0, 0, 0, 0)
            end,

            [241] = function() -- Feed chocobo
                -- Complete the trade here to prevent any cheesing
                player:confirmTrade()

                for idx, itemId in ipairs(chocoState.foodGiven) do
                    local itemData     = validFoods[itemId]
                    local hungerAmount = itemData[1]
                    local energyAmount = itemData[3]
                    local glowColor   = itemData[10]

                    player:messageSpecial(ID.text.CHOCOBO_FEEDING_ITEM, itemId, idx)

                    -- TODO: Handle item effects

                    if hasCondition(chocoState) then
                        for _, condition in pairs(chocoState.conditions) do
                            if getCondition(chocoState, condition) then
                                local foodCureTable = conditionsHealedByItems[condition]

                                if foodCureTable then
                                    if utils.contains(itemId, foodCureTable) then
                                        -- TODO: Play CS for healing condition, or messaging?
                                        setCondition(chocoState, condition, false)
                                    end
                                end
                            end
                        end
                    end

                    local reaction = 1

                    chocoState.hunger = utils.clamp(chocoState.hunger + hungerAmount, 0, 255)
                    chocoState.energy = utils.clamp(chocoState.energy + energyAmount, 0, 100)

                    -- If multiple items, glow is always green
                    if #chocoState.foodGiven > 1 then
                        glowColor = glow.GREEN
                    end

                    player:updateEvent(10, glowColor, 0, 0, reaction, numberToRank(chocoState.hunger), 0, 0)
                end

                chocoState.foodGiven = nil

                updateChocoState(player, chocoState)
            end,

            [244] = function() -- Present chocobo appearance
                -- TODO: There is more information going on in here

                -- TODO: These appearance changes are locked in on day 29 if
                -- they are 'Average' (128) or above. This will need to be
                -- written to the db and this part rewritten.

                -- Crest type
                local enlargedCrest = 0

                if chocoState.discernment >= 128 then
                    enlargedCrest = 1
                end

                -- Feet type
                local enlargedFeet = 0

                if chocoState.strength >= 128 then
                    enlargedFeet = 1
                end

                -- Tail feathers type
                local moreTailFeathers = 0

                if chocoState.endurance >= 128 then
                    moreTailFeathers = 1
                end

                -- Event update parameters.
                player:updateEvent(chocoState.color, enlargedCrest, enlargedFeet, moreTailFeathers, chocoState.stage, 1, 0, 0)
            end,

            [46] = function() -- Ask about chocobo's condition (menu)
                player:updateEvent(0, 0, 0, 0, 0, 0, 0, 0)
            end,

            [600] = function()
                -- Get KI during another CS (determined randomly)
                local ki    = xi.ki.DIRTY_HANDKERCHIEF
                local getKi = 1

                player:updateEvent(ki, 0, 0, 0, 0, getKi, 0, 0)
                player:addKeyItem(ki)
            end,

            [251] = function() -- Ask about chocobo's condition (confirm)
                -- Block all other information
                --local blockFlag = bit.lshift(0x01, 31) -- Sorry, but you will have to do this later. I have something new to report.
                local arg0 = 251
                local arg1 = packStats1(chocoState)
                local arg2 = bit.lshift(affectionRank.PARENT, 0) + bit.lshift(chocoState.hunger, 16)
                local arg3 = bit.lshift(chocoState.personality, 0) +
                    bit.lshift(chocoState.weather_preference, 4) +
                    bit.lshift(chocoState.ability1, 8) +
                    bit.lshift(chocoState.ability2, 12) +
                    bit.lshift(chocoState.stage, 16)

                -- Condition flags (can be combined)
                -- No flags: Stable
                -- local legWounded = bit.lshift(0x01, 0)
                -- local slightlyIll = bit.lshift(0x01, 1)
                -- local stomachAche = bit.lshift(0x01, 2)
                -- local depressed = bit.lshift(0x01, 3)
                -- local excellentCondition = bit.lshift(0x01, 4)
                -- local sleepingSoundly = bit.lshift(0x01, 5)
                -- local veryIll = bit.lshift(0x01, 6)
                -- local boredRestless = bit.lshift(0x01, 7)
                -- local hopelesslySpoiled = bit.lshift(0x01, 8)
                -- local ranAway = bit.lshift(0x01, 9)
                -- local inLove = bit.lshift(0x01, 10)
                -- local makingAFuss = bit.lshift(0x01, 11)
                -- local fullOfEnergy = bit.lshift(0x01, 12)
                -- local brightAndFocussed = bit.lshift(0x01, 13)
                local arg4 = 0 -- fullOfEnergy + brightAndFocussed

                player:updateEvent(arg0, arg1, arg2, arg3, arg4, 0, 0, 0)
            end,

            [243] = function() -- Care for your chocobo (menu)
                local watchOverChocobo  = 0x01
                local tellAStory        = 0x02
                local scoldTheChocobo   = 0x04
                local competeWithOthers = 0x08
                local goOnAWalkShort    = 0x10
                local goOnAWalkRegular  = 0x20
                local goOnAWalkLong     = 0x40
                local mask              = 0x7FFFFFFF - watchOverChocobo

                if chocoState.stage >= stage.CHICK then
                    mask = mask - scoldTheChocobo - goOnAWalkShort
                end

                if chocoState.stage >= stage.ADOLESCENT then
                    mask = mask - tellAStory - goOnAWalkRegular
                    -- TODO: Is this unlocked per-chocobo, or per-player?
                    -- TODO: competeWithOthers: Available at adolescent stage; You must go on a regular walk to unlock this.
                    if true then
                        mask = mask - competeWithOthers
                    end
                end

                if chocoState.stage >= stage.ADULT_1 then
                    mask = mask - goOnAWalkLong
                end

                player:updateEvent(mask, chocoState.energy, 0, 0, 0, 0, 0, 0)
            end,

            [10994] = function() -- Go on a walk (Short) - Leisurely / Brisk
                table.insert(chocoState.csList, cutscenes.TAKE_A_WALK)

                player:updateEventString(chocoState.first_name, chocoState.last_name, chocoState.first_name, chocoState.last_name,
                    0, 0, 0, 0, 0, 0, 0, 0)

                local csData =
                {
                    -- Sandoria (Chick)
                    -- [0] = { 0, 0,  2, 0, 0, 0, 0, 0 }, -- Find lost chocobo
                    [1] = { 0, 0,  7, 0, 0, 0, 0, 0 }, -- Find item (chocobo takes home)
                    -- [2] = { 0, 0,  0, 0, 0, 0, 0, 0 }, -- Nothing?
                    [2] = { 0, 0, 3, 256, 0, 3, 0, 0 }, -- Meet Ace

                    -- Bastok (Chick)
                    -- [11] = {},

                    -- Windurst (Chick)
                    -- [20] = { 0, 0, 7, 0,   0, 0, 0, 0 }, -- Get KI
                    -- [21] = { 0, 0, 2, 0,   0, 0, 0, 0 }, -- Find lost chocobo
                    -- [22] = { 0, 0, 0, 0,   0, 0, 0, 0 }, -- Nothing?
                    -- [23] = { 0, 0, 3, 256, 0, 1, 0, 0 }, -- Meet Ace
                    -- [24] = { 0, 0, 0, 0,   0, 0, 0, 0 }, -- Nothing?
                    -- [25] = { 0, 0, 7, 0,   0, 0, 0, 0 }, -- Find item (chocobo takes home)
                }

                local baseCS       = csidTable[player:getZoneID()][6]
                local energyAmount =  walkEnergyAmount[1] + math.random(0, walkEnergyRandomness)
                local energyFlag   = 0

                if chocoState.energy < energyAmount then
                    energyFlag = -1
                else
                    chocoState.energy = chocoState.energy - energyAmount
                end

                local walkZoneId = shortWalkLocation[raisingLocation[player:getZoneID()]]
                local csWeather  = getWeatherInZone(walkZoneId)
                local output     = { 0, 0, 0, 0, 0, 0, 0, 0 }

                -- Will there be an event?
                if math.random(1, 100) <= walkEventChance then
                    local possibleEvents = {}

                    -- If not holding an item, it's possible to find an item
                    if chocoState.held_item == 0 then
                        table.insert(possibleEvents, 1)
                    end

                    -- If you haven't completed the White Handkerchief quest yet
                    if not player:hasKeyItem(xi.keyItem.WHITE_HANDKERCHIEF) then
                        table.insert(possibleEvents, 2)
                    end

                    -- TODO: Meet other chocobos & raisers

                    local randomEvent = utils.randomEntry(possibleEvents)
                    if randomEvent then
                        output = { unpack(csData[randomEvent]) }
                    end
                end

                output[1] = baseCS
                output[2] = energyFlag
                output[5] = chocoState.stage
                output[8] = csWeather

                -- TODO: This is a bit confusing
                if output[3] == 7 and energyFlag >= 0 then -- Chocobo found an item
                    local itemId         = utils.randomEntry(walkItems[walkZoneId])
                    output[2]            = itemId
                    chocoState.held_item = itemId
                end

                player:updateEvent(unpack(output))
            end,

            [11250] = function() -- Go on a walk (Regular) - Leisurely / Brisk
                table.insert(chocoState.csList, cutscenes.TAKE_A_WALK)

                player:updateEventString(chocoState.first_name, chocoState.last_name, chocoState.first_name, chocoState.last_name,
                    0, 0, 0, 0, 0, 0, 0, 0)

                local csData =
                {
                    [1] = { 0, 0,  7, 0, 0, 0, 0, 0 }, -- Find item (chocobo takes home)
                }

                local baseCS       = csidTable[player:getZoneID()][6]
                local energyAmount =  walkEnergyAmount[2] + math.random(0, walkEnergyRandomness)
                local energyFlag   = 0

                if chocoState.energy < energyAmount then
                    energyFlag = -1
                else
                    chocoState.energy = chocoState.energy - energyAmount
                end

                local walkZoneId = mediumWalkLocation[raisingLocation[player:getZoneID()]]
                local csWeather  = getWeatherInZone(walkZoneId)

                local output = { 0, 0, 0, 0, 0, 0, 0, 0 }

                -- Will there be an event?
                if math.random(1, 100) <= walkEventChance then
                    -- TODO: Hard-coded to randomly finding an item
                    output = { unpack(csData[1]) }
                end

                output[1] = baseCS
                output[2] = energyFlag
                output[5] = chocoState.stage
                output[8] = csWeather

                -- If the chocobo is going to find and item, but already has one:
                -- Don't play the cutscene!
                if output[3] == 7 and chocoState.held_item > 0 then
                    output[3] = 0
                end

                if output[3] == 7 and energyFlag >= 0 then -- Chocobo found an item
                    local itemId         = utils.randomEntry(walkItems[walkZoneId])
                    output[2]            = itemId
                    chocoState.held_item = itemId
                end

                player:updateEvent(unpack(output))
            end,

            [11506] = function() -- Go on a walk (Long) - Leisurely / Brisk
                table.insert(chocoState.csList, cutscenes.TAKE_A_WALK)

                player:updateEventString(chocoState.first_name, chocoState.last_name, chocoState.first_name, chocoState.last_name,
                    0, 0, 0, 0, 0, 0, 0, 0)

                local csData =
                {
                    [1] = { 0, 0,  7, 0, 0, 0, 0, 0 }, -- Find item (chocobo takes home)
                }

                local baseCS       = csidTable[player:getZoneID()][6]
                local energyAmount =  walkEnergyAmount[3] + math.random(0, walkEnergyRandomness)
                local energyFlag   = 0

                if chocoState.energy < energyAmount then
                    energyFlag = -1
                else
                    chocoState.energy = chocoState.energy - energyAmount
                end

                local walkZoneId = longWalkLocation[raisingLocation[player:getZoneID()]]
                local csWeather  = getWeatherInZone(walkZoneId)
                local output     = { 0, 0, 0, 0, 0, 0, 0, 0 }

                -- Will there be an event?
                if math.random(1, 100) <= walkEventChance then
                    -- TODO: Hard-coded to randomly finding an item
                    output = { unpack(csData[1]) }
                end

                output[1] = baseCS
                output[2] = energyFlag
                output[5] = chocoState.stage
                output[8] = csWeather

                -- If the chocobo is going to find and item, but already has one:
                -- Don't play the cutscene!
                if output[3] == 7 and chocoState.held_item > 0 then
                    output[3] = 0
                end

                if output[3] == 7 and energyFlag >= 0 then -- Chocobo found an item
                    local itemId         = utils.randomEntry(walkItems[walkZoneId])
                    output[2]            = itemId
                    chocoState.held_item = itemId
                end

                player:updateEvent(unpack(output))
            end,

            [12530] = function() -- Watch over your your chocobo (confirm)
                player:updateEventString(chocoState.first_name, chocoState.last_name, chocoState.first_name, chocoState.last_name,
                    0, 0, 0, 0, 0, 0, 0)

                local baseCS = csidTable[player:getZoneID()][9]

                if chocoState.stage == stage.EGG then
                    -- Your egg does not seem to be in the best condition at the moment...
                    local badEggFlag = 0 -- bit.lshift(0x01, 31) (1st arg)

                    player:updateEvent(baseCS, badEggFlag, 0, 0, 0, 0, 0, 0)
                else
                    local energyFlag = 0

                    if chocoState.energy < watchOverEnergy then
                        energyFlag = -1
                    else
                        chocoState.energy = chocoState.energy - watchOverEnergy
                    end

                    -- Sandy: 304, 14396, 0, 0, 6, 0, 0, 2
                    -- Windurst: 816, 18250, 1, 511, 2, 0, 0, 1
                    local givingItem = 0
                    local givenItem  = 0

                    if chocoState.held_item > 0 then
                        givingItem = 1
                        givenItem  = chocoState.held_item
                    end

                    if
                        givingItem == 1 and
                        player:getFreeSlotsCount() == 0
                    then
                        givingItem = 2
                    end

                    player:updateEvent(baseCS, energyFlag, givingItem, givenItem, 2, 0, 0, 1)

                    if givingItem == 1 then
                        player:addItem({ id = givenItem, silent = true })
                        chocoState.held_item = 0
                    end
                end
            end,

            [13042] = function() -- Tell a story
                -- A chocobo must have a DSC of D (A bit deficient, 64-95) or
                -- higher to have a chance at learning a skill from a story
                if chocoState.discernment >= 64 then
                    utils.unused()
                    -- TODO: Chance to learn skill
                end

                local storyMask = 0xFFFFFF9C

                chocoState = onRaisingEventPlayout(player, cutscenes.INTERESTED_IN_YOUR_STORY, chocoState)

                player:updateEventString(chocoState.first_name, chocoState.last_name, chocoState.first_name, chocoState.last_name, 0, 0, 0, 0, 0, 0, 0)
                player:updateEvent(getCutsceneWithOffset(player, cutscenes.INTERESTED_IN_YOUR_STORY), 0, storyMask, 0, chocoState.stage, 0, 0, 3)
                updateChocoState(player, chocoState)
            end,

            [13298] = function() -- Scold the chocobo
                chocoState = onRaisingEventPlayout(player, cutscenes.HANGS_HEAD_IN_SHAME, chocoState)

                player:updateEventString(chocoState.first_name, chocoState.last_name, chocoState.first_name, chocoState.last_name, 0, 0, 0, 0, 0, 0, 0)
                player:updateEvent(getCutsceneWithOffset(player, cutscenes.HANGS_HEAD_IN_SHAME), 0, 0, 0, chocoState.stage, 0, 0, 0)
                updateChocoState(player, chocoState)
            end,

            [13554] = function() -- Compete with others
                -- player:updateEventString(chocoState.first_name, chocoState.last_name, chocoState.first_name, chocoState.last_name,
                --     4163, 67, 0, 0, 0, 0, 0)
                -- player:updateEvent(820, 18017, 0, 72, 3, 254, 46, 1)

                -- 0: player chocobo, 1: tie, 2: rival chocobo
                -- NOTE: The guides claim that the winner is random, so
                --     : let's make it 50/50 to start with, and then a small
                --     : chance on top for a tie.
                local winner = utils.randomEntry({ 0, 2 })
                if math.random(1, 100) <= 5 then
                    winner = 1
                end

                local winnerStr =
                {
                    [0] = 'Player',
                    [1] = 'Tie',
                    [2] = 'Rival',
                }

                debug('Competition Winner: ' .. winnerStr[winner])

                -- TODO: Use relevant name for area
                local rivalsName = 'Hero'

                -- TODO: Hook up rival's look

                -- TODO: Track wins in chocoState+db, only need to track up to 3

                chocoState = onRaisingEventPlayout(player, cutscenes.COMPETE_WITH_OTHERS, chocoState)

                player:updateEventString(chocoState.first_name, rivalsName, '', '', 0, 0, 0, 0, 0, 0, 0)
                player:updateEvent(getCutsceneWithOffset(player, cutscenes.COMPETE_WITH_OTHERS), 0, winner, 0, chocoState.stage, 0, 0, 0)
            end,

            [250] = function() -- Set Basic Care (menu)
                local plan1Length = bit.rshift(bit.band(chocoState.care_plan, 0xF0000000), 28)
                local plan1Type   = bit.rshift(bit.band(chocoState.care_plan, 0x0F000000), 24)
                local plan2Length = bit.rshift(bit.band(chocoState.care_plan, 0x00F00000), 20)
                local plan2Type   = bit.rshift(bit.band(chocoState.care_plan, 0x000F0000), 16)
                local plan3Length = bit.rshift(bit.band(chocoState.care_plan, 0x0000F000), 12)
                local plan3Type   = bit.rshift(bit.band(chocoState.care_plan, 0x00000F00),  8)
                local plan4Length = bit.rshift(bit.band(chocoState.care_plan, 0x000000F0),  4)
                local plan4Type   = bit.rshift(bit.band(chocoState.care_plan, 0x0000000F),  0)

                local planInfo =
                    bit.lshift(plan1Length,   0) + bit.lshift(plan1Type,   3) +
                    bit.lshift(plan2Length,   8) + bit.lshift(plan2Type,  11) +
                    bit.lshift(plan3Length,  16) + bit.lshift(plan3Type,  19) +
                    bit.lshift(plan4Length,  24) + bit.lshift(plan4Type,  27)

                -- TODO: Set up mask for relevant stage
                local menuMask = 0 -- 0x7FFFFFFE

                player:updateEvent(250, planInfo, 0, 0, 0, 0, 0, menuMask)
            end,

            [254] = function() -- Set Basic Care plan 1
                player:updateEvent(0, 0, 0, 0, 0, 0, 0, 0)
            end,

            [510] = function() -- Set Basic Care plan 2
                player:updateEvent(0, 0, 0, 0, 0, 0, 0, 0)
            end,

            [766] = function() -- Set Basic Care plan 3
                player:updateEvent(0, 0, 0, 0, 0, 0, 0, 0)
            end,

            [1022] = function() -- Set Basic Care plan 4
                player:updateEvent(0, 0, 0, 0, 0, 0, 0, 0)
            end,

            [1056] = function() -- Unknown
                print('ChocoboRaising: Unknown update: 1056')
                player:updateEvent(0, 0, 0, 0, 0, 0, 0, 0)
            end,

            [1241] = function() -- Called during 'Compete with Others'
                -- Appears to always be blank
                player:updateEvent(0, 0, 0, 0, 0, 0, 0, 0)
            end,

            [246] = function() -- Update CS
                chocoState = handleCSUpdate(player, chocoState, true)
            end,

            [256] = function() -- Brief report?
                --
            end,

            [504] = function() -- Skip report
                -- TODO: Set up movement between chocoState.report.events and chocoState.csList to
                --     : include the length of each playout in days, so it can be used in handleCSUpdate()
                --     : to multiply values etc.
                -- Prepare chocoState.csList
                for _, currentEvent in pairs (chocoState.report.events) do
                    local eventStartStart = currentEvent[1]
                    -- local eventStartEnd = currentEvent[2]
                    local eventCSList = currentEvent[3]

                    chocoState.age   = eventStartStart
                    chocoState.stage = ageToStage(chocoState.age)

                    for _, cs in pairs(eventCSList) do
                        table.insert(chocoState.csList, cs)
                    end
                end

                chocoState.report.events = {}

                -- NOTE: each cs will be popped off inside of handleCSUpdate
                while #chocoState.csList > 0 do
                    chocoState = handleCSUpdate(player, chocoState, false)
                end

                updateChocoState(player, chocoState)
            end,

            [221] = function() -- Buy your chocobo whistle
                --
            end,

            [222] = function() -- Recieve your chocobo whistle
                --
            end,

            [482] = function() -- DEBUG: Go forward 1 unit
                -- TODO: Split stored age and time of creation so age can be manipulated
                player:updateEvent(0, 0, 0, 0, 0, 0, 0, 0)
            end,

            [229] = function() -- DEBUG: Abilities print
                player:updateEvent(1, packStats1(chocoState), packStats2(chocoState), 0, 0, 0, 0, 0)
            end,

            [232] = function() -- DEBUG: User work print
                -- TODO: Should we be tracking all user interactions with the chocobo?
            end,

            [240] = function() -- Give up your chocobo
                player:updateEvent(0, 0, 0, 0, 0, 0, 0, 0)
                player:deleteRaisedChocobo()
            end,

            [255] = function() -- Synthetic update: Change/set chocobo name
                -- If the name is still 'Chocobo Chocobo' then the renaming failed or was
                -- rejected, play the appropriate response.
                if chocoState.first_name == 'Chocobo' and chocoState.last_name == 'Chocobo' then
                    player:updateEvent(1, 1, 1, 1, 1, 1, 1, 1)
                else
                    player:updateEvent(0, 0, 0, 0, 0, 0, 0, 0)
                end
            end,

            [40] = function() -- Retire your chocobo
                player:updateEvent(0, 0, 0, 0, 0, 0, 0, 0)
                player:deleteRaisedChocobo()
            end,
        }
    end
end

xi.chocoboRaising.onEventFinishVCSTrainer = function(player, csid, option, npc)
    if not xi.settings.main.ENABLE_CHOCOBO_RAISING then
        return
    end

    local mainCsid   = csidTable[player:getZoneID()][2]
    local tradeCsid  = csidTable[player:getZoneID()][3]
    local chocoState = xi.chocoboRaising.chocoState[player:getID()]

    if csid == tradeCsid and option == 252 then
        -- TODO: Validate this! Really validate this!
        --     : It has to be the same egg item as was traded at the start of the CS!
        local trade = player:getTrade()
        local egg   = trade:getItem()

        -- TODO: Make sure problems here don't leak into core and cause a crash!
        local newChoco = xi.chocoboRaising.newChocobo(player, egg)

        if player:setChocoboRaisingInfo(newChoco) then
            player:confirmTrade()
        end
    elseif csid == mainCsid and option == 215 then
        if chocoState == nil then
            print('ERROR! onEventFinishVCSTrainer \'chocoState\' is nil!')

            return
        end

        updateChocoState(player, chocoState)
    end

    -- TODO: Hand out cards and plaques etc.
end
