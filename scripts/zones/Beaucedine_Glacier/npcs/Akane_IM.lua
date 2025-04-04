-----------------------------------
-- Area: Beaucedine Glacier
--  NPC: Akane, I.M.
-- Type: Outpost Conquest Guards
-- !pos -24.351 -60.421 -114.215 111
-----------------------------------
---@type TNpcEntity
local entity = {}

local guardNation = xi.nation.BASTOK
local guardType   = xi.conquest.guard.OUTPOST
local guardRegion = xi.region.FAUREGANDI
local guardEvent  = 32761

entity.onTrade = function(player, npc, trade)
    xi.conquest.overseerOnTrade(player, npc, trade, guardNation, guardType)
end

entity.onTrigger = function(player, npc)
    xi.conquest.overseerOnTrigger(player, npc, guardNation, guardType, guardEvent, guardRegion)
end

entity.onEventUpdate = function(player, csid, option, npc)
    xi.conquest.overseerOnEventUpdate(player, csid, option, guardNation)
end

entity.onEventFinish = function(player, csid, option, npc)
    xi.conquest.overseerOnEventFinish(player, csid, option, guardNation, guardType, guardRegion)
end

return entity
