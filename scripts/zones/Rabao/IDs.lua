-----------------------------------
-- Area: Rabao
-----------------------------------
zones = zones or {}

zones[xi.zone.RABAO] =
{
    text =
    {
        HOMEPOINT_SET                 = 2,     -- Home point set!
        ASSIST_CHANNEL                = 6402,  -- You will be able to use the Assist Channel until #/#/# at #:# (JST).
        ITEM_CANNOT_BE_OBTAINED       = 6406,  -- You cannot obtain the <item>. Come back after sorting your inventory.
        ITEM_OBTAINED                 = 6412,  -- Obtained: <item>.
        GIL_OBTAINED                  = 6413,  -- Obtained <number> gil.
        KEYITEM_OBTAINED              = 6415,  -- Obtained key item: <keyitem>.
        NOT_HAVE_ENOUGH_GIL           = 6417,  -- You do not have enough gil.
        CARRIED_OVER_POINTS           = 6451,  -- You have carried over <number> login point[/s].
        LOGIN_CAMPAIGN_UNDERWAY       = 6452,  -- The [/January/February/March/April/May/June/July/August/September/October/November/December] <number> Login Campaign is currently underway!
        LOGIN_NUMBER                  = 6453,  -- In celebration of your most recent login (login no. <number>), we have provided you with <number> points! You currently have a total of <number> points.
        MEMBERS_LEVELS_ARE_RESTRICTED = 6473,  -- Your party is unable to participate because certain members' levels are restricted.
        CONQUEST_BASE                 = 6514,  -- Tallying conquest results...
        FISHING_MESSAGE_OFFSET        = 6673,  -- You can't fish here.
        REGIME_CANCELED               = 6873,  -- Current training regime canceled.
        HUNT_ACCEPTED                 = 6891,  -- Hunt accepted!
        USE_SCYLDS                    = 6892,  -- You use <number> [scyld/scylds]. Scyld balance: <number>.
        HUNT_RECORDED                 = 6903,  -- You record your hunt.
        OBTAIN_SCYLDS                 = 6905,  -- You obtain <number> [scyld/scylds]! Current balance: <number> [scyld/scylds].
        HUNT_CANCELED                 = 6909,  -- Hunt canceled.
		ACCEPTED_KEYITEM              = 9999,  -- Accepted Key Items: <keyitem> and <keyitem>.																					  
        PAKHI_DELIVERY_DIALOG         = 10041, -- When your pack is fit to burrrst, send your non-essential items to your delivery box and bam, prrroblem solved!
        SPIRIT_DELIVERY_DIALOG        = 10042, -- We can deliver goods to your residence or to the residences of your friends.
        SHINY_TEETH_SHOP_DIALOG       = 10046, -- Well met, adventurer. If you're looking for a weapon to carve through those desert beasts, you've come to the right place.
        BRAVEWOLF_SHOP_DIALOG         = 10047, -- For rainy days and windy days, or for days when someone tries to thrust a spear in your guts, having a good set of armor can set your mind at ease.
        BRAVEOX_SHOP_DIALOG           = 10048, -- These days, you can get weapons and armor cheap at the auction houses. But magic is expensive no matter where you go.
        SCAMPLIX_SHOP_DIALOG          = 10049, -- No problem, Scamplix not bad guy. Scamplix is good guy, sells stuff to adventurers. Scamplix got lots of good stuff for you.
        GARUDA_UNLOCKED               = 10129, -- You are now able to summon [Ifrit/Titan/Leviathan/Garuda/Shiva/Ramuh].
        NOMAD_MOOGLE_DIALOG           = 10200, -- I'm a traveling moogle, kupo. I help adventurers in the Outlands access items they have stored in a Mog House elsewhere, kupo.
        GENEROIT_SHOP_DIALOG          = 10318, -- Ho there! I am called Generoit. I have everything here for the chocobo enthusiast, and other rare items galore.
        RETRIEVE_DIALOG_ID            = 10775, -- You retrieve <item> from the porter moogle's care.
        COMMON_SENSE_SURVIVAL         = 11853, -- It appears that you have arrived at a new survival guide provided by the Adventurers' Mutual Aid Network. Common sense dictates that you should now be able to teleport here from similar tomes throughout the world.
    },
    mob =
    {
    },
    npc =
    {
    },
}

return zones[xi.zone.RABAO]
