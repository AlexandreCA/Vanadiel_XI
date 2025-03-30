-----------------------------------
-- Area: Bastok Mines
--  NPC: Synergy Engineer
-- !pos -43.2409 0.000 -64.1494
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrade = function(player, npc, trade)
    player:printToPlayer("Debug: Trade triggered")
end

entity.onTrigger = function(player, npc)
    player:printToPlayer("Debug: Starting event 11001")
    player:startEvent(11001)
end

entity.onEventUpdate = function(player, csid, option, npc)
    if csid == 11001 and option == 12 then
        xi.synergy.buySynergyCrucible(player, 100)
    end
end

entity.onEventFinish = function(player, csid, option, npc)
end

return entity