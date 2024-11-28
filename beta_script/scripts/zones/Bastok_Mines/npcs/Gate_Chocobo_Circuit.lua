-----------------------------------
-- Area: Bastok Mines
-- NPC: Gate: Chocobo Circuit
-----------------------------------
local ID = zones[xi.zone.BASTOK_MINES]
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    player:startEvent(566)
end

entity.onEventUpdate = function(player, csid, option, npc)
end

entity.onEventFinish = function(player, csid, option, npc)
	if csid == 566 and option == 1 then
	player:setPos(0, -3, 0, 0, 32)
end

return entity