-----------------------------------
-- Royal Puppeteer
-- Aht Uhrgan Mission 12
-----------------------------------
-- !addmission 4 11
-- Naja Salaheem : !pos 22.700 -8.804 -45.591 50
-- Pyopyoroon    : !pos 22.112 0 24.682 53
-----------------------------------

local mission = Mission:new(xi.mission.log_id.TOAU, xi.mission.id.toau.ROYAL_PUPPETEER)

mission.reward =
{
    keyItem     = xi.ki.VIAL_OF_SPECTRAL_SCENT,
    nextMission = { xi.mission.log_id.TOAU, xi.mission.id.toau.LOST_KINGDOM },
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
            ['Naja_Salaheem'] =
            {
                onTrigger = function(player, npc)
                    return mission:event(3071, xi.besieged.getMercenaryRank(player), 1, 0, 0, 0, 0, 0, 0, 0)
                end,
            },
        },

        [xi.zone.NASHMAU] =
        {
            ['Pyopyoroon'] =
            {
                onTrade = function(player, npc, trade)
                    if
                        player:getMissionStatus(mission.areaId) == 1 and
                        npcUtil.tradeHasExactly(trade, xi.item.VIAL_OF_JODYS_ACID)
                    then
                        return mission:progressEvent(279)
                    end
                end,

                onTrigger = function(player, npc)
                    local missionStatus = player:getMissionStatus(mission.areaId)

                    if missionStatus == 0 then
                        return mission:progressEvent(277)
                    elseif missionStatus == 1 then
                        return mission:event(278)
                    end
                end,
            },

            onEventFinish =
            {
                [277] = function(player, csid, option, npc)
                    player:setMissionStatus(mission.areaId, 1)
                end,

                [279] = function(player, csid, option, npc)
                    if mission:complete(player) then
                        player:confirmTrade()
                    end
                end,
            },
        },
    },
}

return mission
