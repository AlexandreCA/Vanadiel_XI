-----------------------------------
-- Area: Kazham
--  NPC: Cha Chalco
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrigger = function(player, npc)
    player:sendMenu(xi.menuType.AUCTION)
end

return entity
