-----------------------------------
-- Area: The Eldieme Necropolis
--  NPC: Leviathan's Gate
-- !pos 249 -34 -60 195
-----------------------------------
local func = require('scripts/zones/The_Eldieme_Necropolis/globals')
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrigger = function(player, npc)
    func.gateOnTrigger(player, npc)
end

return entity
