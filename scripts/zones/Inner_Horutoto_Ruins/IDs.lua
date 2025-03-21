-----------------------------------
-- Area: Inner Horutoto Ruins (192)
-----------------------------------
zones = zones or {}

zones[xi.zone.INNER_HORUTOTO_RUINS] =
{
    text =
    {
        PORTAL_SEALED_BY_3_MAGIC      = 8,     -- The Sealed Portal is sealed by three kinds of magic.
        PORTAL_NOT_OPEN_THAT_SIDE     = 9,     -- The Sealed Portal cannot be opened from this side.
        CONQUEST_BASE                 = 10,    -- Tallying conquest results...
        ITEM_CANNOT_BE_OBTAINED       = 6553,  -- You cannot obtain the <item>. Come back after sorting your inventory.
        ITEM_OBTAINED                 = 6559,  -- Obtained: <item>.
        GIL_OBTAINED                  = 6560,  -- Obtained <number> gil.
        KEYITEM_OBTAINED              = 6562,  -- Obtained key item: <keyitem>.
        FELLOW_MESSAGE_OFFSET         = 6588,  -- I'm ready. I suppose.
        CARRIED_OVER_POINTS           = 7170,  -- You have carried over <number> login point[/s].
        LOGIN_CAMPAIGN_UNDERWAY       = 7171,  -- The [/January/February/March/April/May/June/July/August/September/October/November/December] <number> Login Campaign is currently underway!
        LOGIN_NUMBER                  = 7172,  -- In celebration of your most recent login (login no. <number>), we have provided you with <number> points! You currently have a total of <number> points.
        GEOMAGNETRON_ATTUNED          = 7181,  -- Your <keyitem> has been attuned to a geomagnetic fount in the corresponding locale.
        MEMBERS_LEVELS_ARE_RESTRICTED = 7192,  -- Your party is unable to participate because certain members' levels are restricted.
        NOT_BROKEN_ORB                = 7249,  -- The Mana Orb in this receptacle is not broken.
        EXAMINED_RECEPTACLE           = 7250,  -- You have already examined this receptacle.
        DOOR_FIRMLY_CLOSED            = 7277,  -- The door is firmly closed.
        CAT_BURGLARS_HIDEOUT          = 7278,  -- It looks like that Cat Burglar's hideout lies behind this door! You were able to confirm <keyitem>!
        CHEST_UNLOCKED                = 7353,  -- You unlock the chest!
        PLAYER_OBTAINS_ITEM           = 7416,  -- <name> obtains <item>!
        UNABLE_TO_OBTAIN_ITEM         = 7417,  -- You were unable to obtain the item.
        PLAYER_OBTAINS_TEMP_ITEM      = 7418,  -- <name> obtains the temporary item: <item>!
        ALREADY_POSSESS_TEMP          = 7419,  -- You already possess that temporary item.
        NO_COMBINATION                = 7424,  -- You were unable to enter a combination.
        REGIME_REGISTERED             = 9502,  -- New training regime registered!
        COMMON_SENSE_SURVIVAL         = 10550, -- It appears that you have arrived at a new survival guide provided by the Adventurers' Mutual Aid Network. Common sense dictates that you should now be able to teleport here from similar tomes throughout the world.
    },
    mob =
    {
        SLENDLIX_SPINDLETHUMB = GetFirstID('Slendlix_Spindlethumb'),
        NOCUOUS_WEAPON        = GetFirstID('Nocuous_Weapon'),
        MAGICKED_BONES        = GetFirstID('Magicked_Bones'),
        --[[
            -2    Goblin Thug
            -1    Goblin Weaver
             0    Magicked Bones (with club)
            +1    Magicked Bones (with knife)
        ]]
    },
    npc =
    {
        PORTAL_CIRCLE_BASE = GetFirstID('_5cm'),
        TREASURE_CHEST     = GetFirstID('Treasure_Chest'),
    },
}

return zones[xi.zone.INNER_HORUTOTO_RUINS]
