-----------------------------------
-- Area: Konschtat Highlands
--  NPC: Stone Monument
--  Involved in quest "An Explorer's Footsteps"
-- !pos -102.355 7.981 253.706 108
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrade = function(player, npc, trade)
    if
        npcUtil.tradeHas(trade, xi.item.LUMP_OF_SELBINA_CLAY) and
        npcUtil.giveItem(player, xi.item.CLAY_TABLET)
    then
        player:confirmTrade()
        player:setCharVar('anExplorer-CurrentTablet', 0x00080)
    end
end

return entity
