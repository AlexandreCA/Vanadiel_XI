-----------------------------------
-- Fishing
-----------------------------------
local fish_data = require("scripts/globals/fishing/items")
local zone_data = require("scripts/globals/fishing/zones/zones")
-----------------------------------
xi = xi or {}
xi.fishing = xi.fishing or {}

xi.fishing.spots = {}

-- Chargement des points d'eau depuis la base SQL
local function loadFishingSpots()
    local query = "SELECT * FROM water_points"
    local result = sql:query(query)

    for _, row in ipairs(result) do
        local zoneId = tonumber(row.zone_id)
        xi.fishing.spots[zoneId] = xi.fishing.spots[zoneId] or {}

        table.insert(xi.fishing.spots[zoneId], {
            name = row.name,
            x = tonumber(row.pos_x),
            y = tonumber(row.pos_y),
            z = tonumber(row.pos_z),
            radius = tonumber(row.radius),
            default = tonumber(row.is_default) == 1
        })
    end
end

loadFishingSpots()

-- Détermination du point d'eau (par nom)
local function getWaterBody(player)
    local zoneId = player:getZoneID()
    local spots = xi.fishing.spots[zoneId]
    if not spots then return nil end

    local px, py = player:getXPos(), player:getYPos()

    for _, spot in ipairs(spots) do
        local dx, dy = px - spot.x, py - spot.y
        if math.sqrt(dx * dx + dy * dy) <= spot.radius then
            return spot.name
        end
    end

    for _, spot in ipairs(spots) do
        if spot.default then
            return spot.name
        end
    end

    return nil
end

-- Vérifie la proximité à un point d'eau
local function isNearWater(player)
    local zoneId = player:getZoneID()
    local spots = xi.fishing.spots[zoneId]
    if not spots then return false end

    local px, py = player:getXPos(), player:getYPos()

    for _, spot in ipairs(spots) do
        local dx, dy = px - spot.x, py - spot.y
        if math.sqrt(dx * dx + dy * dy) <= spot.radius then
            return true
        end
    end

    return false
end

xi.fishing.zones = zone_data
xi.fishing.items = fish_data
-----------------------------------
local FishingCore = {}

-- Configuration
FishingCore.biteDelayMin = 5
FishingCore.biteDelayMax = 30
FishingCore.tensionGameDuration = 15
FishingCore.requiredTensionScore = 70

-- Définition des points d'eau par zone et coordonnées centrales
local waterBodyZones = {
    ["port_bastok"] = {
        { name = "docks", pos_x = -98.25, pos_y = -54.26, max_distance = 40 }, -- F-8, quais larges
        { name = "general", default = true }, -- Crayfish
    },
    ["giddeus"] = {
        { name = "pond", pos_x = 50.00, pos_y = -30.00, max_distance = 20 },
        { name = "spring", pos_x = 150.00, pos_y = 80.00, max_distance = 20 },
        { name = "general", default = true }, -- Crayfish
    },
    ["rolandberry_fields"] = {
        { name = "Lake", pos_x = 0.00, pos_y = -10.00, max_distance = 20 },
        { name = "general", default = true }, -- Crayfish, Moat Carp
    },
    ["gusgen_mines"] = {
        { name = "pools_first_floor", pos_x = -125.00, pos_y = -150.00, max_distance = 20 },
        { name = "deeper_pools_map_3", pos_x = 150.00, pos_y = 130.00, max_distance = 20 },
        { name = "general_pools", default = true }, -- Tricolored Carp, Black Eel
    },
    ["bastok_markets"] = {
        { name = "canal", pos_x = 0.00, pos_y = -40.00, max_distance = 20 },
        { name = "general", default = true }, -- Fontaine
    },
    ["jugner_forest"] = {
        { name = "general", default = true }, -- Étangs
    },
    ["mhaura"] = {
        { name = "general", default = true }, -- Mer
    },
    ["buburimu_peninsula"] = {
        { name = "general", default = true }, -- Côte
    },
}

-- Fonction pour déterminer le point d'eau
local function getWaterBody(zoneName, player)
    local zoneWaterBodies = waterBodyZones[zoneName:lower()]
    if not zoneWaterBodies then
        return nil -- Pas de points d'eau spécifiques
    end

    local playerX, playerY = player:getXPos(), player:getYPos()
    for _, waterBody in ipairs(zoneWaterBodies) do
        if waterBody.default then
            return waterBody.name
        elseif waterBody.pos_x and waterBody.pos_y then
            local distance = math.sqrt((playerX - waterBody.pos_x)^2 + (playerY - waterBody.pos_y)^2)
            if distance <= waterBody.max_distance then
                return waterBody.name
            end
        end
    end
    return nil
end

-- Vérifie la proximité à l'eau
local function isNearWater(player)
    local zoneName = player:getZoneName():lower()
    local waterBodies = waterBodyZones[zoneName]
    if not waterBodies then
        return false -- Pas de points d'eau définis
    end

    local playerX, playerY = player:getXPos(), player:getYPos()
    for _, waterBody in ipairs(waterBodies) do
        if waterBody.pos_x and waterBody.pos_y then
            local distance = math.sqrt((playerX - waterBody.pos_x)^2 + (playerY - waterBody.pos_y)^2)
            if distance <= waterBody.max_distance then
                return true
            end
        end
    end
    return false
end

-- Fatigue de pêche
local function checkFishingFatigue(player)
    local lastReset = player:getVar("FishingFatigueReset") or 0
    local currentTime = os.time()
    if currentTime - lastReset >= 86400 then
        player:setVar("FishingFatigueCount", 0)
        player:setVar("FishingFatigueReset", currentTime)
    end
    local fatigueCount = player:getVar("FishingFatigueCount") or 0
    if fatigueCount >= 200 then
        player:messageBasic(xi.msg.basic.FISHING_FATIGUE, 0, 0, 0, "")
        return false
    end
    return true
end

-- Bonus de compétence
local function getFishingSkillBonus(player)
    local bonus = 0
    if player:hasItem(13759) then
        bonus = bonus + 40
    end
    return bonus
end

-- Récupération du poisson selon zone
local function getFishInZone(zoneName, baitName, rodName, player)
    local zoneFish = xi.fishing.zones[zoneName:lower()]
    if not zoneFish then
        return nil
    end

    local waterBody = getWaterBody(player)
    local fishList = {}

    -- Si un point d'eau spécifique est trouvé et que la zone a une sous-table
    if waterBody and zoneFish[waterBody] then
        fishList = zoneFish[waterBody]
    else
        -- Sinon, utiliser la sous-table 'general' ou la liste plate
        fishList = zoneFish.general or {}
        for _, fishName in ipairs(zoneFish) do
            table.insert(fishList, fishName)
        end
    end

    local validFish = {}
    for _, fishName in ipairs(fishList) do
        local fish = xi.fishing.items[fishName:lower()]
        if fish and fish.variations[zoneName:lower()] then
            local variation = fish.variations[zoneName:lower()]
            if table.contains(variation.baits, baitName) and table.contains(variation.rods, rodName) then
                table.insert(validFish, fishName)
            end
        end
    end

    if #validFish == 0 then
        player:messageBasic(xi.msg.basic.FISHING_NOTHING_CAUGHT, 0, 0, 0, "")
        return nil
    end
    return validFish[math.random(1, #validFish)]
end

-- Système de test de rang (Retail accurate)
local rankTests = {
    [8]  = {rank = xi.craftRank.RECRUIT,     item = 4401}, -- Moat Carp
    [18] = {rank = xi.craftRank.INITIATE,    item = 4402}, -- Cheval Salmon
    [28] = {rank = xi.craftRank.NOVICE,      item = 4403}, -- Giant Catfish
    [38] = {rank = xi.craftRank.APPRENTICE,  item = 4404}, -- Gugru Tuna
    [48] = {rank = xi.craftRank.JOURNEYMAN,  item = 4405}, -- Monke-Onke
    [58] = {rank = xi.craftRank.CRAFTSMAN,   item = 4406}, -- Bhefhel Marlin
    [68] = {rank = xi.craftRank.ARTISAN,     item = 4407}, -- Bladefish
    [78] = {rank = xi.craftRank.ADEPT,       item = 4408}, -- Three-eyed Fish
    [88] = {rank = xi.craftRank.VETERAN,     item = 4409}, -- Gigant Squid
    [98] = {rank = xi.craftRank.EXPERT,      item = 4410}, -- Tiger Shark
}

local function checkRankProgress(player, fishingSkill)
    local currentRank = player:getRank(xi.guild.FISHING) or xi.craftRank.NOVICE

    for levelReq, info in pairs(rankTests) do
        if fishingSkill >= levelReq and currentRank < info.rank then
            if player:hasItem(info.item) then
                player:removeItem(info.item)
                player:setRank(xi.guild.FISHING, info.rank)
                player:messageBasic(xi.msg.basic.ITEM_TURNED_IN, info.item)
                player:messageBasic(xi.msg.basic.FISHING_RANK_UP)
            else
                player:messageBasic(xi.msg.basic.FISHING_TEST_REQUIRED, info.item)
            end
            break
        end
    end
end

-- Gain de compétence
local function handleSkillGain(player, fishName, zoneName, success)
    local fishingSkill = player:getSkillLevel(xi.skill.FISHING) + getFishingSkillBonus(player)
    local fish = xi.fishing.items[fishName:lower()]
    local variation = fish and fish.variations[zoneName:lower()]
    local requiredSkill = variation and variation.skill or 0

    local skillDiff = requiredSkill - fishingSkill
    local baseChance = 0.15
    if skillDiff > 0 then
        baseChance = baseChance + (skillDiff * 0.05)
    elseif skillDiff <= -10 then
        baseChance = 0
    end
    baseChance = success and baseChance or baseChance * 0.5
    if player:hasItem(15554) then
        baseChance = baseChance * 1.1
    end

    local maxSkill = 1100
    if fishingSkill >= maxSkill then return end

    if math.random() < baseChance then
        local skillGain = 1
        player:setSkillLevel(xi.skill.FISHING, player:getSkillLevel(xi.skill.FISHING) + skillGain)
        player:messageBasic(xi.msg.basic.SKILL_UP, xi.skill.FISHING, fishingSkill + skillGain)
        checkRankProgress(player, fishingSkill + skillGain)
    end
end

-- Mini-jeu de tension avec messages
local function checkFishingInput(player, fishName, zoneName, rodName)
    local fish = xi.fishing.items[fishName:lower()]
    local variation = fish and fish.variations[zoneName:lower()]
    if not variation then return false end

    local baseScore = math.random(30, 70)
    local skillBonus = (player:getSkillLevel(xi.skill.FISHING) + getFishingSkillBonus(player)) - variation.skill
    local breakChance = variation.break_chance[rodName] or 0.1
    local moonBonus = variation.moon_bonus[xi.moonPhase()] or 1.0
    local weatherBonus = variation.weather_bonus[xi.weather()] or 1.0
    local timeBonus = variation.time_bonus[xi.time()] or 1.0

    -- Ajout des messages d’instinct
    if skillBonus < -15 then
        player:messageBasic(xi.msg.basic.FISHING_FEELING_TERRIBLE)
    elseif skillBonus < 0 then
        player:messageBasic(xi.msg.basic.FISHING_FEELING_BAD)
    else
        player:messageBasic(xi.msg.basic.FISHING_FEELING_GOOD)
    end

    local inputScore = 0
    for _ = 1, FishingCore.tensionGameDuration do
        local input = math.random(-1, 1)
        if input ~= 0 then
            inputScore = inputScore + 10
        end
        if math.random() < breakChance then
            player:messageBasic(xi.msg.basic.FISHING_ROD_BROKE)
            handleSkillGain(player, fishName, zoneName, false)
            return false
        end
    end

    local totalScore = baseScore + inputScore + (skillBonus * 0.5)
    totalScore = totalScore * moonBonus * weatherBonus * timeBonus
    local success = totalScore >= FishingCore.requiredTensionScore
    handleSkillGain(player, fishName, zoneName, success)
    return success
end

-- Résolution de la prise
local function resolveCatch(player, fishName, zoneName)
    local fish = xi.fishing.items[fishName:lower()]
    local fishId = fish and fish.item_id or 4481
    if fishId then
        if player:addItem(fishId) then
            player:setVar("FishingFatigueCount", player:getVar("FishingFatigueCount") + 1)
            player:messageBasic(xi.msg.basic.FISHING_SUCCESS, fishId)
        else
            player:messageBasic(xi.msg.basic.FISHING_FAIL_INV_FULL)
        end
    else
        player:messageBasic(xi.msg.basic.FISHING_FAIL)
    end
end

-- Pêche manuelle avec message de type de prise
function FishingCore.manualFish(player, baitName, rodName)
    if not checkFishingFatigue(player) then return end
    if not isNearWater(player) then
        player:messageBasic(xi.msg.basic.FISHING_NO_WATER)
        return
    end

    local zoneName = player:getZoneName()
    local fishName = getFishInZone(zoneName, baitName, rodName, player)
    if not fishName then return end

    -- Message selon le type de prise
    local fish = xi.fishing.items[fishName:lower()]
    if fish and fish.is_monster then
        player:messageBasic(xi.msg.basic.FISHING_BITE_MONSTER)
    elseif fish and fish.is_item then
        player:messageBasic(xi.msg.basic.FISHING_BITE_ITEM)
    elseif fish and fish.size == "large" then
        player:messageBasic(xi.msg.basic.FISHING_BITE_LARGE)
    else
        player:messageBasic(xi.msg.basic.FISHING_BITE_SMALL)
    end

    local biteDelay = math.random(FishingCore.biteDelayMin, FishingCore.biteDelayMax)
    player:timer(biteDelay * 1000, function()
        if checkFishingInput(player, fishName, zoneName, rodName) then
            resolveCatch(player, fishName, zoneName)
        else
            player:messageBasic(xi.msg.basic.FISHING_LOST_CATCH)
        end
    end)
end

-- Pêche automatique (boucle naïve, améliorable)
function FishingCore.autoFish(player, baitName, rodName)
    while player:getHP() > 0 and checkFishingFatigue(player) do
        FishingCore.manualFish(player, baitName, rodName)
        player:timer(5000, function() end)
    end
end

-- Fonction de test
function xi.fishing.test()
    print("xi.fishing est implémenté")
end

return FishingCore