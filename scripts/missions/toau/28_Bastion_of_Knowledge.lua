-----------------------------------
-- Bastion of Knowledge
-- Aht Uhrgan Mission 28
-----------------------------------
-- !addmission 4 27
-----------------------------------

local mission = Mission:new(xi.mission.log_id.TOAU, xi.mission.id.toau.BASTION_OF_KNOWLEDGE)

mission.reward =
{
    title       = xi.title.APHMAUS_MERCENARY,
    nextMission = { xi.mission.log_id.TOAU, xi.mission.id.toau.PUPPET_IN_PERIL },
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
                    return mission:event(3116, xi.besieged.getMercenaryRank(player), 1, 0, 0, 0, 0, 0, 0, 0)
                end,
            },

            onTriggerAreaEnter =
            {
                [4] = function(player, triggerArea)
                    return mission:progressEvent(3112, 1, 1, 0, 0, 0, 0, 0, 0)
                end,
            },

            onEventFinish =
            {
                [3112] = function(player, csid, option, npc)
                    mission:complete(player)
                end,
            },
        },
    },
}

return mission
