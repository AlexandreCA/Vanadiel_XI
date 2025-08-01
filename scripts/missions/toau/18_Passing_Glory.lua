-----------------------------------
-- Passing Glory
-- Aht Uhrgan Mission 18
-----------------------------------
-- !addmission 4 17
-- Naja Salaheem : !pos 22.700 -8.804 -45.591 50
-----------------------------------

local mission = Mission:new(xi.mission.log_id.TOAU, xi.mission.id.toau.PASSING_GLORY)

mission.reward =
{
    nextMission = { xi.mission.log_id.TOAU, xi.mission.id.toau.SWEETS_FOR_THE_SOUL },
}

mission.sections =
{
    {
        check = function(player, currentMission, missionStatus, vars)
            return currentMission == mission.missionId and
                not mission:getMustZone(player) and
                VanadielUniqueDay() >= mission:getVar(player, 'Timer')
        end,

        [xi.zone.AHT_URHGAN_WHITEGATE] =
        {
            onTriggerAreaEnter =
            {
                [3] = function(player, triggerArea)
                    return mission:progressEvent(3090, { text_table = 0 })
                end,
            },

            onEventUpdate =
            {
                [3090] = function(player, csid, option, npc)
                    if option == 1 then
                        player:updateEvent(xi.besieged.getMercenaryRank(player), 1, 0, 0, 0, 0, 1, 0)
                    end
                end,
            },

            onEventFinish =
            {
                [3090] = function(player, csid, option, npc)
                    mission:complete(player)
                end,
            },
        },
    },
}

return mission
