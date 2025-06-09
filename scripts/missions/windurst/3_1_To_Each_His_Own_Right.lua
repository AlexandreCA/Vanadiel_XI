-----------------------------------
-- To Each His Own Right
-- Windurst M3-1
-----------------------------------
-- !addmission 2 10
-- Rakoh Buuma      : !pos 106 -5 -23 241
-- Mokyokyo         : !pos -55 -8 227 238
-- Janshura-Rashura : !pos -227 -8 184 240
-- Zokima-Rokima    : !pos 0 -16 124 239
-- Kupipi           : !pos 2 0.1 30 242
-- Rhy Epocan       : !pos 2 -48 14 242
-- Hakkuru-Rinkuru  : !pos -111 -4 101 240
-- Trap Door        : !pos 22.310 -1.087 -14.320 151
-----------------------------------

local mission = Mission:new(xi.mission.log_id.WINDURST, xi.mission.id.windurst.TO_EACH_HIS_OWN_RIGHT)

mission.reward =
{
    rankPoints = 450,
}

local handleAcceptMission = function(player, csid, option, npc)
    if option == 10 then
        mission:begin(player)
        player:messageSpecial(zones[player:getZoneID()].text.YOU_ACCEPT_THE_MISSION)
    end
end

mission.sections =
{
    {
        check = function(player, currentMission, missionStatus, vars)
            -- Permet de proposer la mission si le joueur ne fait rien et qu'il est éligible
            return currentMission == xi.mission.id.windurst.TO_EACH_HIS_OWN_RIGHT or
                (currentMission == xi.mission.id.nation.NONE and
                 player:getNation() == mission.areaId and
                 player:getRank() == 2 and
                 player:getMissionRankPoints() >= 1500)
        end,

        [xi.zone.PORT_WINDURST] =
        {
            onEventFinish =
            {
                [78] = handleAcceptMission,
            },
        },

        [xi.zone.WINDURST_WALLS] =
        {
            onEventFinish =
            {
                [93] = handleAcceptMission,
            },
        },

        [xi.zone.WINDURST_WATERS] =
        {
            onEventFinish =
            {
                [111] = handleAcceptMission,
            },
        },

        [xi.zone.WINDURST_WOODS] =
        {
            onEventFinish =
            {
                [114] = handleAcceptMission,
            },
        },
    },

    {
        check = function(player, currentMission, missionStatus, vars)
            return currentMission == mission.missionId
        end,

        [xi.zone.HEAVENS_TOWER] =
        {
            ['Kupipi'] =
            {
                onTrigger = function(player, npc)
                    local currentMission = player:getCurrentMission(mission.areaId)
                    local missionStatus = player:getMissionStatus(mission.areaId)

                    if currentMission == xi.mission.id.nation.NONE then
                        player:startEvent(78)  -- Menu Accepter/Refuser
                    elseif missionStatus == 0 then
                        return mission:progressEvent(103, 0, 0, xi.ki.STARWAY_STAIRWAY_BAUBLE)
                    elseif missionStatus == 1 then
                        return mission:progressEvent(104)
                    end
                end,
            },

            ['Rhy_Epocan'] =
            {
                onTrigger = function(player, npc)
                    local missionStatus = player:getMissionStatus(mission.areaId)

                    if missionStatus == 1 then
                        return mission:progressEvent(107)
                    elseif missionStatus == 2 then
                        return mission:progressEvent(108)
                    elseif missionStatus == 4 then
                        return mission:progressEvent(114)
                    end
                end,
            },

            onEventFinish =
            {
                [78] = function(player, csid, option, npc)
                    if option == 10 then
                        mission:begin(player)
                        player:messageSpecial(zones[player:getZoneID()].text.YOU_ACCEPT_THE_MISSION)
                    end
                end,

                [103] = function(player, csid, option, npc)
                    player:setMissionStatus(mission.areaId, 1)
                    npcUtil.giveKeyItem(player, xi.ki.STARWAY_STAIRWAY_BAUBLE)
                end,

                [107] = function(player, csid, option, npc)
                    player:setMissionStatus(mission.areaId, 2)
                end,

                [114] = function(player, csid, option, npc)
                    mission:complete(player)
                end,
            },
        },

        [xi.zone.PORT_WINDURST] =
        {
            ['Hakkuru-Rinkuru'] =
            {
                onTrigger = function(player, npc)
                    if player:getMissionStatus(mission.areaId) == 2 then
                        return mission:progressEvent(147)
                    end
                end,
            },

            onEventFinish =
            {
                [147] = function(player, csid, option, npc)
                    player:setMissionStatus(mission.areaId, 3)
                end,
            },
        },

        [xi.zone.CASTLE_OZTROJA] =
        {
            onEventFinish =
            {
                [43] = function(player, csid, option, npc)
                    player:setMissionStatus(mission.areaId, 4)
                end,
            },
        },
    },
}

return mission
