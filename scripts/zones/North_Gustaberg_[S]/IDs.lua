-----------------------------------
-- Area: North_Gustaberg_[S]
-----------------------------------
zones = zones or {}

zones[xi.zone.NORTH_GUSTABERG_S] =
{
    text =
    {
        ITEM_CANNOT_BE_OBTAINED       = 6384, -- You cannot obtain the <item>. Come back after sorting your inventory.
        ITEM_OBTAINED                 = 6390, -- Obtained: <item>.
        GIL_OBTAINED                  = 6391, -- Obtained <number> gil.
        KEYITEM_OBTAINED              = 6393, -- Obtained key item: <keyitem>.
        CARRIED_OVER_POINTS           = 7001, -- You have carried over <number> login point[/s].
        LOGIN_CAMPAIGN_UNDERWAY       = 7002, -- The [/January/February/March/April/May/June/July/August/September/October/November/December] <number> Login Campaign is currently underway!
        LOGIN_NUMBER                  = 7003, -- In celebration of your most recent login (login no. <number>), we have provided you with <number> points! You currently have a total of <number> points.
        MEMBERS_LEVELS_ARE_RESTRICTED = 7023, -- Your party is unable to participate because certain members' levels are restricted.
        LYCOPODIUM_ENTRANCED          = 7071, -- The lycopodium is entranced by a sparkling light...
        CAMPAIGN_RESULTS_TALLIED      = 7285, -- Campaign results tallied.
        FISHING_MESSAGE_OFFSET        = 7370, -- You can't fish here.
        MINING_IS_POSSIBLE_HERE       = 7559, -- Mining is possible here if you have <item>.
		NO_WAY_PAST_BARRIER           = 7927, -- It seems there is no way past this imposing barrier...																							   
        VOIDWALKER_DESPAWN            = 8144, -- The monster fades before your eyes, a look of disappointment on its face.
        VOIDWALKER_NO_MOB             = 8191, -- The <keyitem> quivers ever so slightly, but emits no light. There seem to be no monsters in the area.
        VOIDWALKER_MOB_TOO_FAR        = 8192, -- The <keyitem> quivers ever so slightly and emits a faint light. There seem to be no monsters in the immediate vicinity.
        VOIDWALKER_MOB_HINT           = 8193, -- The <keyitem> resonates [feebly/softly/solidly/strongly/very strongly/furiously], sending a radiant beam of light lancing towards a spot roughly <number> [yalm/yalms] [east/southeast/south/southwest/west/northwest/north/northeast] of here.
        VOIDWALKER_SPAWN_MOB          = 8194, -- A monster materializes out of nowhere!
        VOIDWALKER_UPGRADE_KI_1       = 8196, -- The <keyitem> takes on a slightly deeper hue and becomes <keyitem>!
        VOIDWALKER_UPGRADE_KI_2       = 8197, -- The <keyitem> takes on a deeper, richer hue and becomes <keyitem>!
        VOIDWALKER_BREAK_KI           = 8198, -- The <keyitem> shatters into tiny fragments.
        VOIDWALKER_OBTAIN_KI          = 8199, -- Obtained key item: <keyitem>!
        COMMON_SENSE_SURVIVAL         = 9091, -- It appears that you have arrived at a new survival guide provided by the Servicemen's Mutual Aid Network. Common sense dictates that you should now be able to teleport here from similar tomes throughout the world.
    },

    mob =
    {
        ANKABUT    = GetFirstID('Ankabut'),
        GLOOMANITA = GetFirstID('Gloomanita'),

        VOIDWALKER =
        {
            [xi.keyItem.CLEAR_ABYSSITE] =
            {
                17138086, -- Globster
                17138085, -- Globster
                17138084, -- Globster
                17138083, -- Globster
                17138082, -- Ground Guzzler
                17138081, -- Ground Guzzler
                17138080, -- Ground Guzzler
                17138079, -- Ground Guzzler
            },

            [xi.keyItem.COLORFUL_ABYSSITE] =
            {
                17138078, -- Lamprey Lord
                17138077, -- Shoggoth
            },

            [xi.keyItem.ORANGE_ABYSSITE] =
            {
                17138070, -- Blobdingnag
            },

            [xi.keyItem.BLACK_ABYSSITE] =
            {
                17138069, -- Yilbegan
            }
        }
    },

    pet =
    {
        [17138070] = -- Blobdingnag
        {
            17138076, -- Septic Boils
            17138075, -- Septic Boils
            17138074, -- Septic Boils
            17138073, -- Septic Boils
            17138072, -- Septic Boils
            17138071, -- Septic Boils
        },
    },

    npc =
    {
        CAMPAIGN_NPC_OFFSET = GetFirstID('Estineau_RK'), -- San, Bas, Win, Flag +4, CA
        MINING              = GetTableOfIDs('Mining_Point'),
    },
}

return zones[xi.zone.NORTH_GUSTABERG_S]
