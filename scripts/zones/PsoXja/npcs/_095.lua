-----------------------------------
-- Area: Pso'Xja
--  NPC: _095 (Stone Gate)
-- Notes: Spawns Gargoyle when triggered
-- !pos 298.399 -1.925 -110.000 9
-----------------------------------
local psoXjaGlobal = require('scripts/zones/PsoXja/globals')
-----------------------------------
---@type TNpcEntity
local entity = {}

local correctSideOfDoor = function(player)
    return player:getXPos() >= 299
end

entity.onTrade = function(player, npc, trade)
    psoXjaGlobal.attemptPickLock(player, npc, trade, correctSideOfDoor(player))
end

entity.onTrigger = function(player, npc)
    psoXjaGlobal.attemptOpenDoor(player, npc, correctSideOfDoor(player))
end

entity.onEventFinish = function(player, csid, option, npc)
    psoXjaGlobal.cs26EventFinish(player, csid, option)
end

return entity
