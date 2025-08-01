-----------------------------------
-- In the Blood
-- Aht Uhrgan Mission 32
-----------------------------------
-- !addmission 4 31
-- Naja Salaheem : !pos 22.700 -8.804 -45.591 50
-----------------------------------

local mission = Mission:new(xi.mission.log_id.TOAU, xi.mission.id.toau.IN_THE_BLOOD)

mission.reward =
{
    item        = xi.item.IMPERIAL_GOLD_PIECE,
    nextMission = { xi.mission.log_id.TOAU, xi.mission.id.toau.SENTINELS_HONOR },
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
                    return mission:progressEvent(3113, xi.besieged.getMercenaryRank(player), 1, 0, 0, 0, 0, 0, 0, 0)
                end,
            },

            onEventFinish =
            {
                [3113] = function(player, csid, option, npc)
                    if mission:complete(player) then
                        player:setCharVar('Mission[4][32]Timer', VanadielUniqueDay() + 1)
                        player:setLocalVar('Mission[4][32]mustZone', 1)
                    end
                end,
            },
        },
    },
}

return mission
