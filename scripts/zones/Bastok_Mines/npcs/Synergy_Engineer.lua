-----------------------------------
-- Area: Bastok Mines
--  NPC: Synergy Engineer
-- !pos -43.2409 0.000 -64.1494
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
	player:startEvent(11001) -- Déclenche l'événement 11001
end

entity.onEventUpdate = function(player, csid, option, npc)
end

entity.onEventFinish = function(player, csid, option, npc)
    if csid == 11001 and option == 3 then -- Option 3 = "Acheter le Synergy Crucible"
        xi.synergy.buySynergyCrucible(player, 100)
    end
    xi.synergy.onEventFinishEngineer(player, csid, option, npc) -- Garde la fonction existante
end

return entity