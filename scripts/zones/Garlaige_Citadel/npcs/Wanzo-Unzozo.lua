-----------------------------------
-- Area: Garlaige Citadel
--  NPC: Wanzo-Unzozo
-- !pos -379.420 -10.749 383.312 200
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    player:startEvent(60)
end

entity.onEventUpdate = function(player, csid, option, npc)
end

entity.onEventFinish = function(player, csid, option, npc)
end

return entity
