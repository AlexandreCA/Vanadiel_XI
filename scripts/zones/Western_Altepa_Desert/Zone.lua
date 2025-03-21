-----------------------------------
-- Zone: Western_Altepa_Desert (125)
-----------------------------------
local ID = zones[xi.zone.WESTERN_ALTEPA_DESERT]
require('scripts/quests/i_can_hear_a_rainbow')
require('scripts/missions/amk/helpers')
-----------------------------------
---@type TZone
local zoneObject = {}

zoneObject.onInitialize = function(zone)
    UpdateNMSpawnPoint(ID.mob.KING_VINEGARROON)
    GetMobByID(ID.mob.KING_VINEGARROON):setRespawnTime(math.random(900, 10800))

    xi.beastmenTreasure.updatePeddlestox(xi.zone.YUHTUNGA_JUNGLE, ID.npc.PEDDLESTOX)
end

zoneObject.onGameDay = function()
    xi.beastmenTreasure.updatePeddlestox(xi.zone.WESTERN_ALTEPA_DESERT, ID.npc.PEDDLESTOX)
end

zoneObject.onZoneIn = function(player, prevZone)
    local cs = -1

    if
        player:getXPos() == 0 and
        player:getYPos() == 0 and
        player:getZPos() == 0
    then
        player:setPos(-19.901, 13.607, 440.058, 78)
    end

    if quests.rainbow.onZoneIn(player) then
        cs = 2
    end

    -- AMK06/AMK07
    if xi.settings.main.ENABLE_AMK == 1 then
        xi.amk.helpers.tryRandomlyPlaceDiggingLocation(player)
    end

    return cs
end

zoneObject.onConquestUpdate = function(zone, updatetype, influence, owner, ranking, isConquestAlliance)
    xi.conquest.onConquestUpdate(zone, updatetype, influence, owner, ranking, isConquestAlliance)
end

zoneObject.onTriggerAreaEnter = function(player, triggerArea)
end

zoneObject.onEventUpdate = function(player, csid, option, npc)
    if csid == 2 then
        quests.rainbow.onEventUpdate(player)
    end
end

zoneObject.onEventFinish = function(player, csid, option, npc)
end

zoneObject.onZoneWeatherChange = function(weather)
    -- HNM King Vinegarroon only spawns during earth weather
    local kvMob = GetMobByID(ID.mob.KING_VINEGARROON)

    if kvMob then
        if weather == xi.weather.DUST_STORM or weather == xi.weather.SAND_STORM then
            DisallowRespawn(ID.mob.KING_VINEGARROON, false) -- Allow respawn.

            -- Check for respawn.
            if
                not kvMob:isSpawned() and
                kvMob:getRespawnTime() == 0
            then
                if
                    (weather == xi.weather.DUST_STORM and math.random(1, 100) <= 10) or
                    weather == xi.weather.SAND_STORM
                then
                    SpawnMob(ID.mob.KING_VINEGARROON)
                end
            end

        else
            DisallowRespawn(ID.mob.KING_VINEGARROON, true) -- Disallow respawn.
        end
    end

    -- NM Dahu only spawns during fire or earth weather
    local dahu = GetMobByID(ID.mob.DAHU)

    if dahu then
        local dahuValidWeather =
        {
            xi.weather.DUST_STORM,
            xi.weather.SAND_STORM,
            xi.weather.HOT_SPELL,
            xi.weather.HEAT_WAVE,
        }

        if utils.contains(weather, dahuValidWeather) then
            DisallowRespawn(ID.mob.DAHU, false) -- Allow respawn.

            -- Spawn if respawn is up
            if
                not dahu:isSpawned() and
                dahu:getRespawnTime() == 0
            then
                SpawnMob(ID.mob.DAHU)
            end
        else
            DisallowRespawn(ID.mob.DAHU, true) -- Disallow respawn.
        end
    end
end

zoneObject.afterZoneIn = function(player)
    -- Send players who zone in an update for the Altepa Gate "doors" so you can see the state from further away
    -- TODO: these NPCs should be "permanently" in the NPC spawn list for all players -- there's a bug if you get too close and move away they revert to the "needs to be opened" state.
    -- This currently acts as a small QoL from a long distance, better than nothing, but closer to retail.
    for gateId = ID.npc.ALTEPA_GATE, ID.npc.ALTEPA_GATE + 8 do
        local gateObj = GetNPCByID(gateId)

        if gateObj then
            player:sendEntityUpdateToPlayer(gateObj, xi.entityUpdate.ENTITY_UPDATE, xi.updateType.UPDATE_COMBAT)
        end
    end
end

return zoneObject
