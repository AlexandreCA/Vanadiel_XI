-----------------------------------
-- Area: Sauromugue Champaign
--  NPC: Stone Monument
-- Involved in quest "An Explorer's Footsteps"
-- !pos 77.544 -2.746 -184.803 120
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrigger = function(player, npc)
    player:startEvent(900)
end

entity.onTrade = function(player, npc, trade)
    if
        npcUtil.tradeHas(trade, xi.item.LUMP_OF_SELBINA_CLAY) and
        npcUtil.giveItem(player, xi.item.CLAY_TABLET)
    then
        player:confirmTrade()
        player:setCharVar('anExplorer-CurrentTablet', 0x08000)
    end
end

return entity
