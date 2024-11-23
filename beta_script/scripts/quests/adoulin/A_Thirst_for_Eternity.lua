-----------------------------------
-- Zone : Eastern Adoulin (257)
-- NPC : Roskin
-- Type : Quête A Thirst for Eternity (non répétable)
-- !pos -36.5290 -0.1500 -24.5645 257
-----------------------------------

---@type TNpcEntity
local entity = {}

-- Activation de la quête avec Roskin
entity.onTalkToRoskin = function(player)
    player:startEvent(1)  -- Activation de la quête et remise de l'objet clé : Elder Wooden Box
end

-- Question de Roskin pour l'activation
entity.onRoskinQuestion = function(player, npc, answer)
    if answer == 1 then  -- Choisir la première réponse pour activer correctement la quête
        player:addKeyItem(2613)  -- Remise de l'objet clé : Elder Wooden Box
        player:startEvent(2)  -- Passage à l'étape suivante
    else
        player:messageSpecial(zones[player:EASTERN_ADOULIN()].text.ROSKIN_QUEST_ALREADY_COMPLETED)  -- Message d'erreur
    end
end

-- Étape de la quête : Rencontre avec Palomel
entity.onTalkToPalomel = function(player)
    player:addKeyItem(2614)  -- Remise de l'objet clé : Imprint Device S
    player:startEvent(3)  -- Passage à l'étape suivante
end

-- Rencontre avec Quwi Orihbhe à Rabao
entity.onTalkToQuwi = function(player)
    player:startEvent(4)  -- Cutscene avec Quwi Orihbhe
end

-- Retour à Roskin pour des instructions supplémentaires (optionnel)
entity.onReturnToRoskin = function(player)
    player:startEvent(5)  -- Roskin vous parle de l'utilisation de l'appareil dans diverses zones
end

-- Restauration des archives : Ceizak Battlegrounds
entity.onVisitCeizak = function(player)
    player:addKeyItem(2618)  -- Remise de l'objet clé : Record of a thousand lights
    player:startEvent(6)  -- Passer à l'étape suivante
end

-- Restauration des archives : Cirdas Caverns
entity.onVisitCirdas = function(player)
    player:addKeyItem(2616)  -- Remise de l'objet clé : Record of a cavernous foray
    player:startEvent(7)  -- Passer à l'étape suivante
end

-- Visite de la station frontière de Yorcia Weald
entity.onVisitYorcia = function(player)
    player:addKeyItem(2615)  -- Remise de l'objet clé : Record of the generals' foray
    player:startEvent(8)  -- Passer à l'étape suivante
end

-- Visite de Kamihr Drifts
entity.onVisitKamihr = function(player)
    player:addKeyItem(2617)  -- Remise de l'objet clé : Record of the knight in black
    player:startEvent(9)  -- Final cutscene et récompense
end

-- Partie 2 : Rala Waterways - Répondre à la question
entity.onVisitRalaWaterways = function(player)
    if player:hasKeyItem(643) then  -- Vérification de l'objet clé
        player:startEvent(10)  -- Lancement de la question
    end
end

-- Résoudre le puzzle de Rala Waterways
entity.onAnswerRalaPuzzle = function(player, npc, answer)
    if answer == "ERGISADE" then
        player:addBayld(10000)  -- Récompense : 10 000 Baylds
        player:startEvent(11)  -- Cutscene avec Palomel
    else
        player:messageSpecial(zones[player:EASTERN_ADOULIN()].text.ROSKIN_QUEST_INCORRECT_ANSWER)  -- Message de réponse incorrecte
    end
end

-- Transition vers la bibliothèque de Celennia Memorial Library
entity.onTalkToRoskinAfterRala = function(player)
    player:startEvent(12)  -- Roskin envoie le joueur à la bibliothèque
end

-- Quiz de la bibliothèque
entity.onLibraryQuizStart = function(player)
    player:startEvent(13)  -- Lancement du quiz de la bibliothèque
end

-- Répondre au quiz
entity.onLibraryQuizAnswer = function(player, npc, answer)
    local correctAnswers = {
        "Scouts Coalition", "Watergarden Coliseum", "Font Xanira", "Rhazowa", "Sverdhried Hillock",
        "200 years ago", "Eastern Adoulin", "Cirdas Caverns", "Leafallia", "Zoldeff River", 
        "Adoulin", "Vortimere", "Sea of Zafmlug"
    }

    if table.contains(correctAnswers, answer) then
        player:addKeyItem(644)  -- Remise du livre d'histoire après le quiz
        player:startEvent(14)  -- Scène finale avec Roskin
    else
        player:messageSpecial(zones[player:EASTERN_ADOULIN()].text.ROSKIN_QUEST_INCORRECT_ANSWER)  -- Message de réponse incorrecte
    end
end

-- Récompense de fin de quête : 8000 Bayld et titre "Thousand-Year Traveler"
entity.onCompleteQuest = function(player)
    player:addBayld(8000)  -- Ajout des Baylds
    player:addTitle(12345)  -- Remise du titre "Thousand-Year Traveler" (remplacez 12345 par l'ID du titre)
    player:messageSpecial(zones[player:EASTERN_ADOULIN()].text.ROSKIN_QUEST_REWARD)
end

return entity
