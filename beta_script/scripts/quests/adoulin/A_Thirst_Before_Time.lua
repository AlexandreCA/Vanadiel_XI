-----------------------------------
-- Zone : Eastern Adoulin (257)
-- NPC : Roskin
-- Type : Quête A Thirst Before Time
-- Position : !pos -34.950 -0.150 -25.140 257
-----------------------------------

---@type TNpcEntity
local entity = {}

-- Activation de la quête avec Roskin (condition préalable)
entity.onTalkToRoskin = function(player)
    if player:hasCompletedQuest("A Thirst for Eternity") and player:hasCompletedQuest("The Curious Case of Melvien") then
        player:startEvent(1)  -- Activation de la quête
    else
        player:messageSpecial(zones[player:EASTERN_ADOULIN()].text.ROSKIN_QUEST_REQUIREMENTS_NOT_MET)  -- Message d'erreur si les prérequis ne sont pas remplis
    end
end

-- Première étape : Rencontre avec Roskin pour obtenir l'Imprint Device S
entity.onTalkToRoskinFirstTime = function(player)
    player:addKeyItem(1234)  -- Remise de l'objet clé : Imprint Device S
    player:startEvent(2)  -- Cutscene d'activation
end

-- Deuxième étape : Rencontre avec Polished Pebble à l'Inventors' Coalition
entity.onTalkToPolishedPebble = function(player)
    player:startEvent(3)  -- Cutscene avec Polished Pebble
end

-- Retour à Roskin pour la cutscene avec Margret et Palomel
entity.onReturnToRoskin = function(player)
    player:startEvent(4)  -- Cutscene avec Margret et Palomel
end

-- Voyage à Yorcia Weald et interaction avec le Well-Kept Cache
entity.onVisitYorciaWeald = function(player)
    player:startEvent(5)  -- Cutscene initiale
end

-- Après le combat contre Inquisitor Mortuus, obtenir le Weathered Haverton hat
entity.onFightInquisitorMortuus = function(player)
    player:addKeyItem(5678)  -- Remise de l'objet clé : Weathered Haverton hat
    player:startEvent(6)  -- Cutscene après le combat avec Balamor, Oston, Lola et Palomel
end

-- Après le combat, obtenir le Forgotten Memory
entity.onObtainForgottenMemory = function(player)
    player:addKeyItem(9101)  -- Remise de l'objet clé : Forgotten Memory
    player:startEvent(7)  -- Final cutscene
end

-- Retour à Eastern Adoulin pour la cutscene
entity.onReturnToEasternAdoulin = function(player)
    player:startEvent(8)  -- Cutscene de retour à Eastern Adoulin
end

-- Rencontre avec Roskin pour la récompense
entity.onTalkToRoskinForReward = function(player)
    player:startEvent(9)  -- Récompense de Roskin
end

-- Optionnel : Échanger l'Erudition Necklace contre 30,000 Bayld
entity.onTradeEruditionNecklace = function(player)
    player:addBayld(30000)  -- Échanger l'Erudition Necklace contre 30,000 Bayld
    player:startEvent(10)  -- Scène après l'échange
end

-- Optionnel : Échanger un Frontier Soda et 30,000 Bayld contre l'Erudition Necklace
entity.onTradeFrontierSodaAndBayld = function(player)
    player:addKeyItem(9102)  -- Remise de l'Erudition Necklace
    player:addBayld(-30000)  -- Retirer 30,000 Bayld
    player:startEvent(11)  -- Scène après l'échange
end

-- Optionnel : Échanger le Weathered Haverton Hat pour 10,000 EXP et 3 High-purity Bayld
entity.onTradeWeatheredHat = function(player)
    player:addExp(10000)  -- Remise de 10,000 EXP
    player:addItem(9103, 3)  -- Remise de 3 High-purity Bayld
    player:startEvent(12)  -- Cutscene de récompense
end

return entity
