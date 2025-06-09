-----------------------------------
-- To Each His Own Right
-- Windurst M3-1
-----------------------------------

local mission = Mission:new(xi.mission.log_id.WINDURST, xi.mission.id.windurst.TO_EACH_HIS_OWN_RIGHT)

mission.reward =
{
    rankPoints = 450,
}

local function handleAcceptMission(player, csid, option, npc)
    if option == 10 then
        mission:begin(player)
        player:messageSpecial(zones[player:getZoneID()].text.YOU_ACCEPT_THE_MISSION)
    end
end

mission.sections =
{
    -- Section pour proposer la mission (quand le joueur n'a pas de mission active)
    {
        check = function(player, currentMission, missionStatus, vars)
            return currentMission == xi.mission.id.nation.NONE and player:getNation() == mission.areaId
        end,

        [xi.zone.PORT_WINDURST] =
        {
            ['Rakoh_Buuma'] =
            {
                onTrigger = function(player, npc)
                    if player:getCurrentMission(mission.areaId) == xi.mission.id.nation.NONE then
                        player:startEvent(78)
                    end
                end,
            },
            onEventFinish =
            {
                [78] = handleAcceptMission,
            },
        },

        [xi.zone.WINDURST_WALLS] =
        {
            ['Mokyokyo'] =
            {
                onTrigger = function(player, npc)
                    if player:getCurrentMission(mission.areaId) == xi.mission.id.nation.NONE then
                        player:startEvent(78)
                    end
                end,
            },
            onEventFinish =
            {
                [78] = handleAcceptMission,
            },
        },

        [xi.zone.WINDURST_WATERS] =
        {
            ['Janshura_Rashura'] =
            {
                onTrigger = function(player, npc)
                    if player:getCurrentMission(mission.areaId) == xi.mission.id.nation.NONE then
                        player:startEvent(78)
                    end
                end,
            },
            onEventFinish =
            {
                [78] = handleAcceptMission,
            },
        },

        [xi.zone.WINDURST_WOODS] =
        {
            ['Zokima_Rokima'] =
            {
                onTrigger = function(player, npc)
                    if player:getCurrentMission(mission.areaId) == xi.mission.id.nation.NONE then
                        player:startEvent(78)
                    end
                end,
            },
            onEventFinish =
            {
                [78] = handleAcceptMission,
            },
        },
    },

    -- Section pour la progression de la mission
    {
        check = function(player, currentMission, missionStatus, vars)
            return currentMission == mission.missionId
        end,

        [xi.zone.HEAVENS_TOWER] =
        {
            ['Kupipi'] =
            {
                onTrigger = function(player, npc)
                    local missionStatus = player:getMissionStatus(mission.areaId)
                    if missionStatus == 0 then
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
            ['Hakkuru_Rinkuru'] =
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
