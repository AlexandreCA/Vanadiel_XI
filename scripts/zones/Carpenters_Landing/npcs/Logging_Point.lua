-----------------------------------
-- Area: Carpenters Landing
--  NPC: Logging Point
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrade = function(player, npc, trade)
    xi.helm.onTrade(player, npc, trade, xi.helmType.LOGGING, 30)
end

entity.onTrigger = function(player, npc)
    xi.helm.onTrigger(player, xi.helmType.LOGGING)
end

return entity
