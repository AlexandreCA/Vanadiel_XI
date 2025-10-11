-----------------------------------
-- Moa Constrictors
-- Balga's Dais KSNM, Atropos Orb
-- !additem 1180
-----------------------------------
local balgasID = zones[xi.zone.BALGAS_DAIS]
-----------------------------------

local content = Battlefield:new({
    zoneId           = xi.zone.BALGAS_DAIS,
    battlefieldId    = xi.battlefield.id.MOA_CONSTRICTORS,
    maxPlayers       = 6,
    timeLimit        = utils.minutes(30),
    index            = 17,
    entryNpc         = 'BC_Entrance',
    exitNpc          = 'Burning_Circle',
    requiredItems    = { xi.item.ATROPOS_ORB, wearMessage = balgasID.text.A_CRACK_HAS_FORMED, wornMessage = balgasID.text.ORB_IS_CRACKED },

    experimental     = true,
})

content:addEssentialMobs({ 'Giant_Moa' })

content.loot =
{
    {
        { itemId = xi.item.GIL,                        weight = 1000, amount = 24000 },
    },

    {
        quantity = 2,
        { itemId = xi.item.COCKATRICE_SKIN,            weight = 1000 },
    },

    {
        { itemId = xi.item.EXPUNGER,                   weight = 250 },
        { itemId = xi.item.HEART_SNATCHER,             weight = 250 },
        { itemId = xi.item.MORGENSTERN,                weight = 250 },
        { itemId = xi.item.GRAVEDIGGER,                weight = 250 },
    },

    {
        { itemId = xi.item.NONE,                       weight = 300 },
        { itemId = xi.item.DODO_SKIN,                  weight = 300 },
        { itemId = xi.item.CLAYMORE_GRIP,              weight = 100 },
        { itemId = xi.item.POLE_GRIP,                  weight = 100 },
        { itemId = xi.item.SPEAR_STRAP,                weight = 200 },
    },

    {
        { itemId = xi.item.ADAMAN_INGOT,               weight = 250 },
        { itemId = xi.item.ORICHALCUM_INGOT,           weight = 250 },
        { itemId = xi.item.ABSORBING_SHIELD,           weight = 500 },
    },

    {
        { itemId = xi.item.EVOKERS_BOOTS,              weight = 250 },
        { itemId = xi.item.OSTREGER_MITTS,             weight = 250 },
        { itemId = xi.item.PINEAL_HAT,                 weight = 250 },
        { itemId = xi.item.TRACKERS_KECKS,             weight = 250 },
    },

    {
        { itemId = xi.item.CHUNK_OF_DARKSTEEL_ORE,     weight =  50 },
        { itemId = xi.item.CHUNK_OF_GOLD_ORE,          weight =  50 },
        { itemId = xi.item.CHUNK_OF_MYTHRIL_ORE,       weight =  50 },
        { itemId = xi.item.CHUNK_OF_PLATINUM_ORE,      weight =  50 },
        { itemId = xi.item.EBONY_LOG,                  weight =  50 },
        { itemId = xi.item.MAHOGANY_LOG,               weight =  50 },
        { itemId = xi.item.PETRIFIED_LOG,              weight =  50 },
        { itemId = xi.item.PHILOSOPHERS_STONE,         weight =  50 },
        { itemId = xi.item.SPOOL_OF_GOLD_THREAD,       weight =  50 },
        { itemId = xi.item.SQUARE_OF_RAINBOW_CLOTH,    weight =  50 },
        { itemId = xi.item.SQUARE_OF_RAXA,             weight =  50 },
        { itemId = xi.item.CORAL_FRAGMENT,             weight =  50 },
        { itemId = xi.item.DEMON_HORN,                 weight =  50 },
        { itemId = xi.item.HANDFUL_OF_WYVERN_SCALES,   weight =  50 },
        { itemId = xi.item.RAM_HORN,                   weight =  50 },
        { itemId = xi.item.SLAB_OF_GRANITE,            weight =  50 },
        { itemId = xi.item.RERAISER,                   weight =  50 },
        { itemId = xi.item.HI_RERAISER,                weight =  50 },
        { itemId = xi.item.VILE_ELIXIR,                weight =  50 },
        { itemId = xi.item.VILE_ELIXIR_P1,             weight =  50 },
    },

    {
        { itemId = xi.item.VIAL_OF_BLACK_BEETLE_BLOOD, weight =  63 },
        { itemId = xi.item.SQUARE_OF_DAMASCENE_CLOTH,  weight =  62 },
        { itemId = xi.item.DAMASCUS_INGOT,             weight =  62 },
        { itemId = xi.item.SPOOL_OF_MALBORO_FIBER,     weight =  63 },
        { itemId = xi.item.PHILOSOPHERS_STONE,         weight = 200 },
        { itemId = xi.item.PHOENIX_FEATHER,            weight = 350 },
        { itemId = xi.item.SQUARE_OF_RAXA,             weight = 200 },
    },
}

return content:register()
