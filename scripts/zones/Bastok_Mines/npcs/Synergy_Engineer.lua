-----------------------------------
-- Zone : Mines de Bastok
-- PNJ : Ingénieur de Synergie
-- !pos -43.2409 0.000 -64.1494
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrade = function(player, npc, trade)
    player:printToPlayer("Debug: Trade triggered")
end

entity.onTrigger = function(player, npc)
    if player:hasKeyItem(xi.keyItem.SYNERGY_CRUCIBLE) then
        player:printToPlayer("Debug: Player has SYNERGY_CRUCIBLE - Starting event 11001 with params 1, 0, 5, 15498, 15499, 15500, 15501, 0")
        player:startEvent(11001, 1, 0, 5, 15498, 15499, 15500, 15501, 0)
    else
        player:printToPlayer("Debug: Player does NOT have SYNERGY_CRUCIBLE - Starting event 11001 with params 1, 0, 0, 0, 0, 0, 0, 0")
        player:startEvent(11001, 1, 0, 0, 0, 0, 0, 0, 0)
    end
end

entity.onEventUpdate = function(player, csid, option, npc)
    player:printToPlayer("Debug: Event update - csid: " .. csid .. ", option: " .. option)
    if csid == 11001 and option == 3 then
        if player:hasKeyItem(xi.keyItem.SYNERGY_CRUCIBLE) then
            player:printToPlayer("Debug: Player has SYNERGY_CRUCIBLE - Calling replenishFewell for option 3")
            xi.synergy.replenishFewell(player, 1234) -- Coût fixé à 1234 gils
        else
            player:printToPlayer("Debug: Player does NOT have SYNERGY_CRUCIBLE - Calling buySynergyCrucible for option 3")
            xi.synergy.buySynergyCrucible(player, 100)
        end
    end
end

entity.onEventFinish = function(player, csid, option, npc)
    player:printToPlayer("Debug: Event finished - csid: " .. csid .. ", option: " .. option)
end

return entity