	-----------------------------------
	-- Area: Eastern Adoulin (257)
	-----------------------------------
	zones = zones or {}
	
	zones[xi.zone.EASTERN_ADOULIN] =
	{
		text =
		{
			-- Messages génériques
			ITEM_CANNOT_BE_OBTAINED        			= 6384,  -- You cannot obtain the <item>. Come back after sorting your inventory.
			ITEM_OBTAINED                  			= 6390,  -- Obtained: <item>.
			GIL_OBTAINED                   			= 6391,  -- Obtained <number> gil.
			KEYITEM_OBTAINED               			= 6393,  -- Obtained key item: <keyitem>.
			LOST_KEYITEM                   			= 6394,  -- Lost key item: <keyitem>.
			NOTHING_OUT_OF_ORDINARY        			= 6404,  -- There is nothing out of the ordinary here.

			-- Messages spécifiques à Roskin
			ROSKIN_QUEST_START              		= 6400,  -- Début de la quête de Roskin.
			ROSKIN_QUEST_COMPLETE           		= 6401,  -- Fin de la quête de Roskin.
			ROSKIN_QUEST_ALREADY_COMPLETED  		= 6405,  -- Vous avez déjà complété la quête "A Thirst for the Ages".
			KEYITEMS_RECEIVED               		= 6406,  -- Vous avez reçu les documents importants de la part de Roskin !
			ROSKIN_QUEST_JUST_COMPLETED     		= 6407,  -- Vous venez de terminer la quête "A Thirst for the Ages".
			MISSING_PERMIT                  		= 6408,  -- Roskin vous dit : 'Vous devez posséder le permis de charte d'Adoulin avant de commencer cette quête.'
			WRONG_ITEM                      		= 6409,  -- Roskin ne semble pas intéressé par cet objet.
			ALREADY_HAS_KEYITEMS            		= 6410,  -- Vous avez déjà reçu les documents importants de la part de Roskin.
			ROSKIN_QUEST_ALREADY_COMPLETED_EONS 	= 6411,  -- Vous avez déjà complété la quête "A Thirst for the Eons".
			KEYITEMS_RECEIVED_EONS          		= 6412,  -- Vous avez reçu les documents importants de la part de Roskin pour "A Thirst for the Eons" !
			ROSKIN_QUEST_JUST_COMPLETED_EONS 		= 6413,  -- Vous venez de terminer la quête "A Thirst for the Eons".
			ALREADY_HAS_KEYITEMS_EONS       		= 6414,  -- Vous avez déjà reçu les documents importants de la part de Roskin pour "A Thirst for the Eons".
			ROSKIN_QUEST_START_ETERNITY     		= 6415,  -- Début de la quête "A Thirst for Eternity".	
			ROSKIN_QUEST_COMPLETE_ETERNITY  		= 6416,  -- Fin de la quête "A Thirst for Eternity".
			ROSKIN_QUEST_ALREADY_COMPLETED_ETERNITY = 6417,  -- Vous avez déjà complété la quête "A Thirst for Eternity".
			KEYITEMS_RECEIVED_ETERNITY      		= 6418,  -- Vous avez reçu les documents éternels de la part de Roskin !
			ROSKIN_QUEST_JUST_COMPLETED_ETERNITY 	= 6419,  -- Vous venez de terminer la quête "A Thirst for Eternity".
			ALREADY_HAS_KEYITEMS_ETERNITY   		= 6420,  -- Vous avez déjà reçu les documents éternels de la part de Roskin pour "A Thirst for Eternity".

			-- Messages liés aux campagnes et points
			CARRIED_OVER_POINTS            			= 7001,  -- You have carried over <number> login point[/s].
			LOGIN_CAMPAIGN_UNDERWAY        			= 7002,  -- The <month> <number> Login Campaign is currently underway!
			LOGIN_NUMBER                   			= 7003,  -- In celebration of your most recent login (login no. <number>), we have provided you with <number> points! You currently have a total of <number> points.
			BAYLD_OBTAINED                 			= 7007,  -- You have obtained <number> bayld!
			NOT_ENOUGH_BAYLD               			= 7009,  -- You do not have enough bayld!
			YOU_CAN_NOW_BECOME             			= 7011,  -- You can now become a [geomancer/rune fencer]!
			MEMBERS_LEVELS_ARE_RESTRICTED  			= 7023,  -- Your party is unable to participate because certain members' levels are restricted.
			YOU_LEARNED_TRUST              			= 7025,  -- You learned Trust: <name>!

			-- Messages liés au Mog Locker et Waypoints
			MOG_LOCKER_OFFSET              			= 7589,  -- Your Mog Locker lease is valid until <timestamp>, kupo.
			WAYPOINT_ATTUNED               			= 7790,  -- Your <keyitem> has been attuned to a geomagnetic fount[/...specific location description].

			-- Messages sur les unités cinétiques (kinetic units)
			EXPENDED_KINETIC_UNITS         			= 7809,  -- You have expended <number> kinetic unit[/s] and will be transported to another locale.
			INSUFFICIENT_UNITS             			= 7810,  -- Your stock of kinetic units is insufficient.
			REACHED_KINETIC_UNIT_LIMIT     			= 7811,  -- You have reached your limit of kinetic units and cannot charge your artifact any further.
			CANNOT_RECEIVE_KINETIC         			= 7812,  -- There is no response. You apparently cannot receive kinetic units from this item.
			ARTIFACT_HAS_BEEN_CHARGED      			= 7813,  -- Your artifact has been charged with <number> kinetic unit[/s]. Your current stock of kinetic units totals <number>.
			ARTIFACT_TERMINAL_VOLUME       			= 7814,  -- Your artifact has been charged to its terminal volume of kinetic units.
			SURPLUS_LOST_TO_AETHER         			= 7815,  -- A surplus of <number> kinetic unit[/s] has been lost to the aether.

			-- Messages divers
			HOMEPOINT_SET                  			= 8305,  -- Home point set!
			COMMON_SENSE_SURVIVAL          			= 13891, -- It appears that you have arrived at a new survival guide provided by the Adventurers' Mutual Aid Network.
		},
		npc =
		{
			[17830083] = { -- ID de Roskin
            onTrigger = function(player, npc)
                -- Vérifie si la quête "A Thirst Before Time" a été complétée
                if player:getVar("AThirstBeforeTimeCompleted") == 1 then
                    player:messageSpecial(zones[xi.zone.EASTERN_ADOULIN].text.ROSKIN_QUEST_JUST_COMPLETED)
                else
                    player:startEvent(6) -- Lance l'événement pour "A Thirst Before Time"
                end
            end,

            onEventFinish = function(player, csid, option, npc)
                if csid == 6 then
                    -- Ajouter la récompense pour la quête "A Thirst Before Time"
                    player:addCurrency("bayld", 10000) -- Récompense de bayld
                    player:setVar("AThirstBeforeTimeCompleted", 1) -- Marquer la quête comme terminée
                    player:messageSpecial(zones[xi.zone.EASTERN_ADOULIN].text.ROSKIN_QUEST_COMPLETE) -- Message de fin de quête
                end
            end,
        },
    },
}
