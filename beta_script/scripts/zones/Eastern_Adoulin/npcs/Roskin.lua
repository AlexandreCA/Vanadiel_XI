-----------------------------------
-- Area: Eastern Adoulin (257)
-- NPC: Roskin
-- Manages quests: A Thirst for the Ages, Eons, Eternity, and Before Time
-- !pos -36.5290 -0.1500 -24.5645 257
-----------------------------------
local ID = zones[xi.zone.EASTERN_ADOULIN]
-----------------------------------

---@type TNpcEntity
local entity = {}

-- Quand le joueur parle à Roskin
entity.onTrigger = function(player, npc)
    -- A THIRST FOR THE AGES
    local cotrQuestStatus = player:getQuestStatus(xi.questLog.ADOULIN, xi.quest.id.adoulin.A_THIRST_FOR_THE_AGES)
    if cotrQuestStatus == xi.questStatus.QUEST_AVAILABLE then
        -- Lancer la CS de début de quête
        player:startEvent(5030)
    end
end

-- Quand un échange avec le NPC a lieu
entity.onTrade = function(player, npc, trade)
    -- Vérifier que le joueur donne un Frontier Soda (ID 5944)
    if trade:hasItemQty(5944, 1) then
        -- Compléter l'échange
        player:tradeComplete()

        -- Lancer la CS 5032 après l'échange
        player:startEvent(5032)
    else
        -- Si l'item n'est pas celui attendu, afficher un message
        player:messageSpecial(ID.text.WRONG_ITEM)
    end
end

-- Quand la CS se termine
entity.onEventFinish = function(player, csid, option, npc)
    -- A THIRST FOR THE AGES
    if csid == 5032 then
    end
end

return entity

