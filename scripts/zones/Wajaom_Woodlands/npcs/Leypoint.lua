-----------------------------------
-- Area: Wajaom Woodlands
--  NPC: Leypoint
-- Teleport point, Quest -- NAVIGATING THE UNFRIENDLY SEAS RELATED
-- !pos -200.027 -8.500 80.058 51
-----------------------------------
local ID = zones[xi.zone.WAJAOM_WOODLANDS]
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrade = function(player, npc, trade)
    if
        player:getQuestStatus(xi.questLog.AHT_URHGAN, xi.quest.id.ahtUrhgan.NAVIGATING_THE_UNFRIENDLY_SEAS) == xi.questStatus.QUEST_ACCEPTED and
        player:getCharVar('NavigatingtheUnfriendlySeas') == 2
    then
        if trade:hasItemQty(xi.item.HYDROGAUGE, 1) and trade:getItemCount() == 1 then -- Trade Hydrogauge
            player:messageSpecial(ID.text.PLACE_HYDROGAUGE, xi.item.HYDROGAUGE) -- You set the <item> in the trench.
            player:tradeComplete() --Trade Complete
            player:setCharVar('NavigatingtheUnfriendlySeas', 3)
            player:setCharVar('Leypoint_waitJTime', GetSystemTime() + 60) -- Wait 60 seconds.
        end
    end
end

entity.onTrigger = function(player, npc)
    if
        player:getQuestStatus(xi.questLog.AHT_URHGAN, xi.quest.id.ahtUrhgan.NAVIGATING_THE_UNFRIENDLY_SEAS) == xi.questStatus.QUEST_ACCEPTED and
        player:getCharVar('NavigatingtheUnfriendlySeas') == 3
    then
        if player:getCharVar('Leypoint_waitJTime') <= GetSystemTime() then
            player:startEvent(508)
            player:setCharVar('NavigatingtheUnfriendlySeas', 4)   -- play cs for having waited enough time
        else
            player:messageSpecial(ID.text.ENIGMATIC_LIGHT, xi.item.HYDROGAUGE)    -- play cs for not waiting long enough
        end
    end
end

return entity
