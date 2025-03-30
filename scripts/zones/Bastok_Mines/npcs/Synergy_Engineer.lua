-----------------------------------
-- Zone : Mines de Bastok
-- PNJ : Ingénieur de Synergie
-- !pos -43.2409 0.000 -64.1494
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    player:startEvent(11001, 1, 0, 5, 15498, 15499, 15500, 15501, 0)
end

entity.onEventUpdate = function(player, csid, option, npc)
    if csid == 11001 and option == 3 then
        xi.synergy.buySynergyCrucible(player, 100)
	elseif option == 5 then
        xi.synergy.replenishFewell(player, 1234, 1, 5, 15498, 15499, 15500, 15501, 0)
    end
end

entity.onEventFinish = function(player, csid, option, npc)
end

xi.synergy.replenishFewell = function(player, cost, fewellType, amount, param1, param2, param3, param4, param5)
    local gil = player:getGil()
    if gil < cost then
        return false
    end
    player:delGil(cost)
    return true
end

return entity