-----------------------------------
-- Puppet in Peril
-- Aht Uhrgan Mission 29
-----------------------------------
-- !addmission 4 28
-- Ornamental Door : !pos 299 0 -199 67
-----------------------------------

local mission = Mission:new(xi.mission.log_id.TOAU, xi.mission.id.toau.PUPPET_IN_PERIL)

mission.reward =
{
    nextMission = { xi.mission.log_id.TOAU, xi.mission.id.toau.PREVALENCE_OF_PIRATES },
}

mission.sections =
{
    {
        check = function(player, currentMission, missionStatus, vars)
            return currentMission == mission.missionId
        end,

        [xi.zone.AHT_URHGAN_WHITEGATE] =
        {
            ['Naja_Salaheem'] =
            {
                onTrigger = function(player, npc)
                    return mission:event(3117, xi.besieged.getMercenaryRank(player), 1, 0, 0, 0, 0, 0, 0, 0)
                end,
            },
        },

        [xi.zone.JADE_SEPULCHER] =
        {
            ['_1v0'] =
            {
                onTrigger = function(player, npc)
                    if player:getMissionStatus(mission.areaId) == 0 then
                        return mission:progressEvent(4, 0, 4, 0, 0, 0, 0, 0, 0)
                    end
                end,
            },

            onEventFinish =
            {
                [4] = function(player, csid, option, npc)
                    player:setMissionStatus(mission.areaId, 1)
                end,

                [32001] = function(player, csid, option, npc)
                    if player:getLocalVar('battlefieldWin') == xi.battlefield.id.PUPPET_IN_PERIL then
                        mission:complete(player)
                    end
                end,
            },
        },
    },
}

return mission
