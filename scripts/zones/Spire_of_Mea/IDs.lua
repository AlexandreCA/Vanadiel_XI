-----------------------------------
-- Area: Spire_of_Mea
-----------------------------------
zones = zones or {}

zones[xi.zone.SPIRE_OF_MEA] =
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
        TIME_IN_THE_BATTLEFIELD_IS_UP = 7069, -- Your time in the battlefield is up! Now exiting...
        PARTY_MEMBERS_ARE_ENGAGED     = 7084, -- The battlefield where your party members are engaged in combat is locked. Access is denied.
        NO_BATTLEFIELD_ENTRY          = 7096, -- You can hear a faint scraping sound from within, but the way is barred by some strange membrane...
        MEMBERS_OF_YOUR_PARTY         = 7375, -- Currently, # members of your party (including yourself) have clearance to enter the battlefield.
        MEMBERS_OF_YOUR_ALLIANCE      = 7376, -- Currently, # members of your alliance (including yourself) have clearance to enter the battlefield.
        TIME_LIMIT_FOR_THIS_BATTLE_IS = 7378, -- The time limit for this battle is <number> minutes.
        ORB_IS_CRACKED                = 7379, -- There is a crack in the %. It no longer contains a monster.
        A_CRACK_HAS_FORMED            = 7380, -- A crack has formed on the <item>, and the beast inside has been unleashed!
        PARTY_MEMBERS_HAVE_FALLEN     = 7414, -- All party members have fallen in battle. Now leaving the battlefield.
        THE_PARTY_WILL_BE_REMOVED     = 7421, -- If all party members' HP are still zero after # minute[/s], the party will be removed from the battlefield.
        FADES_INTO_NOTHINGNESS        = 7429, -- The % fades into nothingness...
        ENTERING_THE_BATTLEFIELD_FOR  = 7620, -- Entering the battlefield for [Ancient Flames Beckon/Playing Host/Empty Desires]!
        CANT_REMEMBER                 = 7650, -- You cannot remember when exactly, but you have obtained <item>!
    },
    mob =
    {
        DELVER = GetFirstID('Delver'),
        ENVIER = GetFirstID('Envier'),
    },
    npc =
    {
    },
}

return zones[xi.zone.SPIRE_OF_MEA]
