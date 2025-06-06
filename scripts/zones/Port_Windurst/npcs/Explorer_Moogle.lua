-----------------------------------
-- Area: Port Windurst
--  NPC: Explorer Moogle
-----------------------------------
---@type TNpcEntity
local entity = {}

local eventId = 854

entity.onTrigger = function(player, npc)
    xi.teleport.explorerMoogleOnTrigger(player, eventId)
end

entity.onEventFinish = function(player, csid, option, npc)
    xi.teleport.explorerMoogleOnEventFinish(player, csid, option, eventId)
end

return entity
