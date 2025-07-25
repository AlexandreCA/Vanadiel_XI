-----------------------------------
-- Sweets for the Soul
-- Aht Uhrgan Mission 19
-----------------------------------
-- !addmission 4 18
-----------------------------------

local mission = Mission:new(xi.mission.log_id.TOAU, xi.mission.id.toau.SWEETS_FOR_THE_SOUL)

mission.reward =
{
    title       = xi.title.KARABABAS_TOUR_GUIDE,
    nextMission = { xi.mission.log_id.TOAU, xi.mission.id.toau.TEAHOUSE_TUMULT },
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
                    return mission:event(3091, xi.besieged.getMercenaryRank(player), 1, 0, 0, 0, 0, 0, 0, 0)
                end,
            },

            onTriggerAreaEnter =
            {
                [5] = function(player, triggerArea)
                    return mission:progressEvent(3092, 1, 1, 0, 0, 0, 0, 0, 0)
                end,
            },

            onEventFinish =
            {
                [3092] = function(player, csid, option, npc)
                    mission:complete(player)
                end,
            },
        },
    },
}

return mission
