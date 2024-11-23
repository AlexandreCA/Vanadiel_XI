-----------------------------------
-- Area: Eastern Adoulin (257)
-- NPC: Roskin
-- Manages quests: A Thirst for the Ages, Eons, Eternity, and Before Time
-- !pos -36.5290 -0.1500 -24.5645 257
-----------------------------------
---@type TNpcEntity
local entity = {}

-- Trade handling
entity.onTrade = function(player, npc, trade)
    if trade:hasItemQty(5944, 1) and player:getVar("AThirstForTheAgesStarted") == 1 then
        player:tradeComplete()
        player:messageSpecial(zones[xi.zone.EASTERN_ADOULIN].text.A_THIRST_FOR_THE_AGES_COMPLETE)
        player:setVar("AThirstForTheAgesCompleted", 1)
        player:addCurrency("bayld", 10000)
    else
        player:messageSpecial(zones[xi.zone.EASTERN_ADOULIN].text.WRONG_ITEM)
    end
end

-- Trigger handling
entity.onTrigger = function(player, npc)
    if player:getVar("AThirstForTheAgesCompleted") == 0 and player:getVar("AThirstForTheAgesStarted") == 1 then
        player:startEvent(10)
    else
        player:startEvent(5030)
    end
end

-- Event finish handling
entity.onEventFinish = function(player, csid, option)
    if csid == 5 then
        if option == 1 then
            player:setVar("AThirstForTheAgesStarted", 1)
            player:messageSpecial(zones[xi.zone.EASTERN_ADOULIN].text.A_THIRST_FOR_THE_AGES_START)
        end
    elseif csid == 10 then
        player:setVar("AThirstForTheAgesCompleted", 1)
        player:messageSpecial(zones[xi.zone.EASTERN_ADOULIN].text.A_THIRST_FOR_THE_AGES_COMPLETE)
        player:addCurrency("bayld", 10000)
    end
end

return entity

