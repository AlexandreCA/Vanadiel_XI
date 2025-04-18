-----------------------------------
-- Zone: Vunkerl_Inlet_[S] (83)
-----------------------------------
local ID = zones[xi.zone.VUNKERL_INLET_S]
-----------------------------------
---@type TZone
local zoneObject = {}

zoneObject.onInitialize = function(zone)
end

zoneObject.onZoneIn = function(player, prevZone)
    local cs = -1

    if
        player:getXPos() == 0 and
        player:getYPos() == 0 and
        player:getZPos() == 0
    then
        player:setPos(-393.238, -50.034, 741.199, 2)
    end

    return cs
end

zoneObject.onZoneWeatherChange = function(weather)
end

zoneObject.onGameHour = function(zone)
    local npc = GetNPCByID(ID.npc.INDESCRIPT_MARKINGS) -- Indescript Markings

    if npc ~= nil then
        if VanadielHour() == 16 then
            npc:setStatus(xi.status.DISAPPEAR)
        end

        if VanadielHour() == 6 then
            npc:setStatus(xi.status.NORMAL)
        end
    end
end

zoneObject.onTriggerAreaEnter = function(player, triggerArea)
end

zoneObject.onEventUpdate = function(player, csid, option, npc)
end

zoneObject.onEventFinish = function(player, csid, option, npc)
end

return zoneObject
