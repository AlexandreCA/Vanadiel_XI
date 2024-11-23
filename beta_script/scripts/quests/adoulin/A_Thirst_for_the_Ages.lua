-----------------------------------
-- Zone : Eastern Adoulin (257)
-- NPC : Roskin
-- Type : Quête A Thirst for the Ages (non répétable)
-- !pos -36.5290 -0.1500 -24.5645 257
-----------------------------------

---@type TNpcEntity
local entity = {}

-- Fonction appelée lors de l'échange (trade) avec l'NPC
entity.onTrade = function(player, npc, trade)
    if trade:hasItemQty(5944, 1) then  -- Frontier Soda
        if player:hasKeyItem(2156) then  -- Adoulinian Charter Permit
            if player:getVar("RoskinQuestCompleted") == 1 then
                player:messageSpecial(zones[player:EASTERN_ADOULIN()].text.ROSKIN_QUEST_ALREADY_COMPLETED)
                return
            end

            trade:confirm()

            player:addKeyItem(2265)  -- Royal Fiat banning colonization
            player:addKeyItem(2266)  -- Record of the 17th Assembly
            player:addKeyItem(2267)  -- Copy of the alliance agreement
            player:messageSpecial(zones[player:EASTERN_ADOULIN()].text.KEYITEMS_RECEIVED)
            player:startEvent(5032)  -- ID de la cutscene associée
            player:setVar("RoskinLastInteraction", os.time())
        else
            player:messageSpecial(zones[player:EASTERN_ADOULIN()].text.MISSING_PERMIT)
        end
    else
        player:messageSpecial(zones[player:EASTERN_ADOULIN()].text.WRONG_ITEM)
    end
end

-- Fonction appelée lorsque le joueur interagit avec l'NPC
entity.onTrigger = function(player, npc)
    if player:hasKeyItem(2156) then  -- Adoulinian Charter Permit
        if player:getVar("RoskinQuestCompleted") == 1 then
            player:messageSpecial(zones[player:EASTERN_ADOULIN()].text.ROSKIN_QUEST_ALREADY_COMPLETED)
            return
        end

        if not player:hasKeyItem(2156) then
            player:addKeyItem(2265)  -- Royal Fiat banning colonization
            player:addKeyItem(2266)  -- Record of the 17th Assembly
            player:addKeyItem(2267)  -- Copy of the alliance agreement
            player:messageSpecial(zones[player:EASTERN_ADOULIN()].text.KEYITEMS_RECEIVED)
            player:startEvent(5032)  -- ID de la cutscene associée
            player:setVar("RoskinLastInteraction", os.time())
        else
            player:messageSpecial(zones[player:EASTERN_ADOULIN()].text.ALREADY_HAS_KEYITEMS)
        end
    else
        player:messageSpecial(zones[player:EASTERN_ADOULIN()].text.MISSING_PERMIT)
    end
end

-- Fonction appelée après la fin de l'événement (cutscene)
entity.onEventFinish = function(player, csid, option, npc)
    if csid == 4 then  -- ID de la cutscene de démarrage
        player:addExperience(1810)
        player:addLimitPoints(1810)
        player:addCurrency("bayld", 1000)
        player:messageSpecial(zones[player:EASTERN_ADOULIN()].text.ROSKIN_QUEST_JUST_COMPLETED)
        player:setVar("RoskinQuestCompleted", 1)
    end
end

return entity
