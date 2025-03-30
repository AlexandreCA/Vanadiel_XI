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
    player:printToPlayer("Debug: Event update - csid: " .. csid .. ", option: " .. option)
end

entity.onEventFinish = function(player, csid, option, npc)
    player:printToPlayer("Debug: Event finished - csid: " .. csid .. ", option: " .. option)
    if csid == 11002 and option == 1 then
        player:printToPlayer("Debug: You chose option " .. option .. ". Testing purchase...")
        xi.synergy.buySynergyCrucible(player, 100)
    end
end

return entity