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
    player:startEvent(11001, 1, 0, 5, 15498, 15499, 15500, 15501, 0)
end

entity.onEventUpdate = function(player, csid, option, npc)
    if csid == 11001 and option == 3 then
        xi.synergy.buySynergyCrucible(player, 100)
    end
end

entity.onEventFinish = function(player, csid, option, npc)
end

return entity