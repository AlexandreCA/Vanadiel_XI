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
    -- Vérifier si la quête est disponible ou acceptée
    local cotrQuestStatus = player:getQuestStatus(xi.questLog.ADOULIN, xi.quest.id.adoulin.A_THIRST_FOR_THE_AGES)
    if cotrQuestStatus == xi.questStatus.QUEST_AVAILABLE then
        -- Lancer la CS de début de quête (5030)
        player:startEvent(5030)
    elseif cotrQuestStatus == xi.questStatus.QUEST_ACCEPTED then
        -- Si la quête est déjà acceptée, lancer la CS 5033 pour demander les Keyitems
        player:startEvent(5033)
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
    end
end    

-- Quand la CS 5032 se termine
entity.onEventFinish = function(player, csid, option, npc)
    if csid == 5032 then
        -- Après l'échange, on attend que le joueur reparle au NPC pour démarrer la CS 5033
        -- Cela n'a pas besoin de faire d'autres actions ici
    elseif csid == 5033 then
        -- Vérifier si le joueur possède tous les Keyitems
        if player:hasKeyItem(2265) and player:hasKeyItem(2266) and player:hasKeyItem(2267) and player:hasKeyItem(2268) and player:hasKeyItem(2269) then
            -- Si tous les keyitems sont présents, lancer la CS 5034
            player:startEvent(5034)
        else
            -- Si le joueur n'a pas tous les keyitems, afficher un message d'erreur
            player:messageSpecial(ID.text.MISSING_KEYITEMS)
        end
    end
end

return entity

