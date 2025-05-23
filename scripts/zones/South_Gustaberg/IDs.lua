-----------------------------------
-- Area: South_Gustaberg
-----------------------------------
zones = zones or {}

zones[xi.zone.SOUTH_GUSTABERG] =
{
    text =
    {
        NOTHING_HAPPENS               = 141,  -- Nothing happens...
        ITEM_CANNOT_BE_OBTAINED       = 6406, -- You cannot obtain the <item>. Come back after sorting your inventory.
        ITEM_OBTAINED                 = 6412, -- Obtained: <item>.
        GIL_OBTAINED                  = 6413, -- Obtained <number> gil.
        KEYITEM_OBTAINED              = 6415, -- Obtained key item: <keyitem>.
        NOTHING_OUT_OF_ORDINARY       = 6426, -- There is nothing out of the ordinary here.
        FELLOW_MESSAGE_OFFSET         = 6441, -- I'm ready. I suppose.
        CARRIED_OVER_POINTS           = 7023, -- You have carried over <number> login point[/s].
        LOGIN_CAMPAIGN_UNDERWAY       = 7024, -- The [/January/February/March/April/May/June/July/August/September/October/November/December] <number> Login Campaign is currently underway!
        LOGIN_NUMBER                  = 7025, -- In celebration of your most recent login (login no. <number>), we have provided you with <number> points! You currently have a total of <number> points.
        MEMBERS_LEVELS_ARE_RESTRICTED = 7045, -- Your party is unable to participate because certain members' levels are restricted.
        CONQUEST_BASE                 = 7086, -- Tallying conquest results...
        FISHING_MESSAGE_OFFSET        = 7245, -- You can't fish here.
        DIG_THROW_AWAY                = 7258, -- You dig up <item>, but your inventory is full. You regretfully throw the <item> away.
        FIND_NOTHING                  = 7260, -- You dig and you dig, but find nothing.
		FOUND_ITEM_WITH_EASE          = 7336, -- It appears your chocobo found this item with ease.
        MONSTER_TRACKS                = 7415, -- You see monster tracks on the ground.
        MONSTER_TRACKS_FRESH          = 7416, -- You see fresh monster tracks on the ground.
        FIRE_GOOD                     = 7419, -- The fire seems to be good enough for cooking.
        FIRE_PUT                      = 7420, -- You put <item> in the fire.
        FIRE_TAKE                     = 7421, -- You take <item> out of the fire.
        FIRE_LONGER                   = 7422, -- It may take a little while more to cook the <item>.
        MEAT_ALREADY_PUT              = 7423, -- The <item> is already in the fire.
        ITEMS_ITEMS_LA_LA             = 7521, -- You can hear a strange voice... Items, items, la la la la la
        GOBLIN_SLIPPED_AWAY           = 7527, -- The Goblin slipped away when you were not looking...
        PLAYER_OBTAINS_ITEM           = 7541, -- <name> obtains <item>!
        UNABLE_TO_OBTAIN_ITEM         = 7542, -- You were unable to obtain the item.
        PLAYER_OBTAINS_TEMP_ITEM      = 7543, -- <name> obtains the temporary item: <item>!
        ALREADY_POSSESS_TEMP          = 7544, -- You already possess that temporary item.
        NO_COMBINATION                = 7549, -- You were unable to enter a combination.
        UNITY_WANTED_BATTLE_INTERACT  = 7611, -- Those who have accepted % must pay # Unity accolades to participate. The content for this Wanted battle is #. [Ready to begin?/You do not have the appropriate object set, so your rewards will be limited.]
		TIME_ELAPSED                  = 7693, -- Time elapsed: <number> [hour/hours] (Vana'diel time) <number> [minute/minutes] and <number> [second/seconds] (Earth time)																																								  
        REGIME_REGISTERED             = 9910, -- New training regime registered!
    },
    mob =
    {
        CARNERO       = GetFirstID('Carnero'), -- TODO: Implement both NMs, there are 2 IDs
        LEAPING_LIZZY = GetTableOfIDs('Leaping_Lizzy'),
        BUBBLY_BERNIE = GetFirstID('Bubbly_Bernie'),
    },
    npc =
    {
    },
}

return zones[xi.zone.SOUTH_GUSTABERG]
