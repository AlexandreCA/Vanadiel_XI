-----------------------------------
-- Area: Aht Urhgan Whitegate
--  NPC: Survival Guide
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrigger = function(player, npc)
    xi.survivalGuide.onTrigger(player)
end

entity.onEventUpdate = function(player, csid, option, npc)
    xi.survivalGuide.onEventUpdate(player, csid, option, npc)
end

entity.onEventFinish = function(player, csid, option, npc)
    xi.survivalGuide.onEventFinish(player, csid, option, npc)
end

return entity
