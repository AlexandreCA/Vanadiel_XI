-----------------------------------
-- Area: Carpenters' Landing
--  NPC: <this space intentionally left blank>
-- !pos -99 -0 -514 2
-----------------------------------
local ID = zones[xi.zone.CARPENTERS_LANDING]
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrade = function(player, npc, trade)
    if
        player:getCharVar('RELIC_IN_PROGRESS') == xi.item.ANCILE and
        npcUtil.tradeHas(trade, { xi.item.RANPERRE_GOLDPIECE, xi.item.SUPERNAL_FRAGMENT, xi.item.SHARD_OF_NECROPSYCHE, xi.item.ANCILE })
    then
        -- currency, shard, necropsyche, stage 4
        player:startEvent(44, xi.item.AEGIS_75)
    end
end

entity.onTrigger = function(player, npc)
    player:messageSpecial(ID.text.NOTHING_OUT_OF_ORDINARY)
end

entity.onEventFinish = function(player, csid, option, npc)
    if
        csid == 44 and
        npcUtil.giveItem(player, { xi.item.AEGIS_75, { xi.item.MONTIONT_SILVERPIECE, 30 } })
    then
        player:confirmTrade()
        player:setCharVar('RELIC_IN_PROGRESS', 0)
    end
end

return entity
