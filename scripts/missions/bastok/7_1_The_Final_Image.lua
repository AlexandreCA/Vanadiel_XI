-----------------------------------
-- The Final Image
-- Bastok M7-1
-----------------------------------
-- !addmission 1 18
-- Argus   : !pos 132.157 7.496 -2.187 236
-- Cleades : !pos -358 -10 -168 235
-- Malduc  : !pos 66.200 -14.999 4.426 237
-- Rashid  : !pos -8.444 -2 -123.575 234
-- Cid     : !pos -12 -12 1 237
-- qm2     : !pos 102 -4 -114 122 (Varies)
-----------------------------------
local bastokMarketsID = zones[xi.zone.BASTOK_MARKETS]
local bastokMinesID   = zones[xi.zone.BASTOK_MINES]
local metalworksID    = zones[xi.zone.METALWORKS]
local portBastokID    = zones[xi.zone.PORT_BASTOK]
local romaeveID       = zones[xi.zone.ROMAEVE]
-----------------------------------

local mission = Mission:new(xi.mission.log_id.BASTOK, xi.mission.id.bastok.THE_FINAL_IMAGE)

mission.reward =
{
    rankPoints = 700,
}

local handleAcceptMission = function(player, csid, option, npc)
    if option == 18 then
        mission:begin(player)
        player:messageSpecial(zones[player:getZoneID()].text.YOU_ACCEPT_THE_MISSION)
    end
end

mission.sections =
{
    {
        check = function(player, currentMission, missionStatus, vars)
            return currentMission == xi.mission.id.nation.NONE and
                player:getNation() == mission.areaId
        end,

        [xi.zone.BASTOK_MARKETS] =
        {
            onEventFinish =
            {
                [1001] = handleAcceptMission,
            },
        },

        [xi.zone.BASTOK_MINES] =
        {
            onEventFinish =
            {
                [1001] = handleAcceptMission,
            },
        },

        [xi.zone.METALWORKS] =
        {
            onEventFinish =
            {
                [1001] = handleAcceptMission,
            },
        },

        [xi.zone.PORT_BASTOK] =
        {
            onEventFinish =
            {
                [1001] = handleAcceptMission,
            },
        },
    },

    {
        check = function(player, currentMission, missionStatus, vars)
            return currentMission == mission.missionId
        end,

        [xi.zone.BASTOK_MARKETS] =
        {
            ['Cleades'] = mission:messageSpecial(bastokMarketsID.text.EXTENDED_MISSION_OFFSET + 5),
        },

        [xi.zone.BASTOK_MINES] =
        {
            ['Rashid'] = mission:messageSpecial(bastokMinesID.text.EXTENDED_MISSION_OFFSET + 5),
        },

        [xi.zone.METALWORKS] =
        {
            ['Cid'] =
            {
                onTrigger = function(player, npc)
                    local missionStatus = player:getMissionStatus(mission.areaId)

                    if missionStatus == 0 then
                        return mission:progressEvent(763)
                    elseif missionStatus == 2 then
                        return mission:progressEvent(764)
                    end
                end,
            },

            ['Malduc'] = mission:messageSpecial(metalworksID.text.EXTENDED_MISSION_OFFSET + 5),

            onEventFinish =
            {
                [763] = function(player, csid, option, npc)
                    player:setMissionStatus(mission.areaId, 1)
                end,

                [764] = function(player, csid, option, npc)
                    if mission:complete(player) then
                        player:delKeyItem(xi.ki.REINFORCED_CERMET)
                    end
                end,
            },
        },

        [xi.zone.PORT_BASTOK] =
        {
            ['Argus'] = mission:messageSpecial(portBastokID.text.EXTENDED_MISSION_OFFSET + 5),
        },

        [xi.zone.ROMAEVE] =
        {
            ['qm2'] =
            {
                onTrigger = function(player, npc)
                    if player:getMissionStatus(mission.areaId) == 1 then
                        if mission:getLocalVar(player, 'nmDefeated') == 1 then
                            player:setMissionStatus(mission.areaId, 2)
                            return mission:keyItem(xi.ki.REINFORCED_CERMET)
                        else
                            npcUtil.popFromQM(player, npc, { romaeveID.mob.MOKKURKALFI, romaeveID.mob.MOKKURKALFI + 1 }, { claim = false, look = true, radius = 2 })
                            npc:hideNPC(0)
                            return mission:messageSpecial(romaeveID.text.A_CHILL_RUNS_DOWN_SPINE)
                        end
                    end
                end,
            },

            ['Mokkurkalfi'] =
            {
                onMobDeath = function(mob, player, optParams)
                    if player:getMissionStatus(mission.areaId) == 1 then
                        mission:setLocalVar(player, 'nmDefeated', 1)
                    end
                end,
            },
        },
    },
}

return mission
