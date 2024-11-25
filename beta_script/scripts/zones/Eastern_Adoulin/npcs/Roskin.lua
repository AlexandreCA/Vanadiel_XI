-----------------------------------
-- Area: Eastern Adoulin (257)
-- NPC: Roskin
-- Manages quests: A Thirst for the Ages, Eons, Eternity, and Before Time
-- !pos -36.5290 -0.1500 -24.5645 257
-----------------------------------
local ID = require("scripts/zones/Eastern_Adoulin/IDs")
-----------------------------------

---@type TNpcEntity
local entity = {}

-- Quand le joueur parle à Roskin
entity.onTrigger = function(player, npc)
    -- Si la quête n'a pas encore été lancée
    if player:getVar("AThirstForTheAgesStarted") == 0 then
        -- Lancer la CS de début de quête
        player:startEvent(5030)
    else
        -- Si la quête a déjà été commencée, ne rien faire
        player:messageSpecial("La quête a déjà commencé.")
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
entity.onEventFinish = function(player, csid, option)
    if csid == 5030 then
        -- Marquer la quête comme commencée
        player:setVar("AThirstForTheAgesStarted", 1)
        player:messageSpecial(ID.text.A_THIRST_FOR_THE_AGES_START)
    elseif csid == 5032 then
        -- Marquer la quête comme complétée
        player:setVar("AThirstForTheAgesCompleted", 1)
        player:messageSpecial(ID.text.A_THIRST_FOR_THE_AGES_COMPLETE)
        player:addCurrency("bayld", 10000)  -- Récompense (exemple)
    end
end

return entity
