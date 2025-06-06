-----------------------------------
-- Area: Yuhtunga Jungle
--  NPC: Uphra-Kophra, W.W.
-- Outpost Conquest Guards
-- !pos -242.487 -1 -402.772 123
-----------------------------------
---@type TNpcEntity
local entity = {}

local guardNation = xi.nation.WINDURST
local guardType   = xi.conquest.guard.OUTPOST
local guardRegion = xi.region.ELSHIMO_LOWLANDS
local guardEvent  = 32759

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
