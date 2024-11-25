-----------------------------------
-- Zone : Eastern Adoulin (257)
-- NPC : Roskin
-- Type : Quête A Thirst for Eternity (non répétable)
-- !pos -36.5290 -0.1500 -24.5645 257
-----------------------------------
local ID = zones[xi.zone.EASTERN_ADOULIN]
-----------------------------------

---@type TNpcEntity
local entity = {}

-- Activation de la quête avec Roskin
entity.onTalkToRoskin = function(player)
    local roskinState = player:getCharVar("RoskinState")  -- Récupère l'état de la quête de Roskin
    if roskinState == 0 then  
        player:startEvent(5124)  -- Activation de la quête en affichant l'événement 5124
        player:setCharVar("RoskinState", 1)  -- Mise à jour de l'état du joueur pour indiquer que la quête est commencée
    end
end

entity.onRoskinQuestion = function(player, npc, answer)
    local roskinState = player:getCharVar("RoskinState")  -- Récupère l'état actuel de la quête

    if roskinState == 0 and answer == nil then
        -- Première interaction : Lancement de l'événement initial
        player:startEvent(5124)  
        player:setCharVar("RoskinState", 1)  -- Met à jour l'état de la quête à 1 (quête commencée)
    elseif roskinState == 1 then
        -- Interaction suivante : Traitement de la réponse
        if answer == 1 then
            -- Donne l'objet clé "Elder Wooden Box" et passe à l'étape suivante
            player:addKeyItem(2613)  
            player:setCharVar("RoskinState", 2)  -- Mise à jour de l'état pour éviter de répéter cette étape
        end
    end
end

entity.onTalkToRoskin = function(player)
	player:startEvent(5125)
end

-- Étape de la quête : Rencontre avec Palomel
entity.onTalkToPalomel = function(player, npc, answer)
    local palomelState = player:getCharVar("PalomelState")  -- Récupère l'état actuel de la quête

    if palomelState == 0 and answer == nil then
        -- Première interaction : Lancer l'événement d'introduction
        player:startEvent(5126)
        player:setCharVar("PalomelState", 1)  -- Mise à jour pour indiquer que l'état passe à 1

    elseif palomelState == 1 then
        -- Répondre à la question avec `answer == 1`
        if answer == 1 then
            -- Donner l'objet clé et terminer le script
            player:addKeyItem(2614)  -- Ajoute l'objet clé : Imprint Device S
        end
    end
end

entity.onTalkToPalomel = function(player)
    elseif palomelState == 2 then
		player:startEvent(5127)
	end
end

-- Rencontre avec Quwi Orihbhe à Rabao 
entity.onQuwiQuestion = function(player, npc, answer)
    local quwiState = player:getCharVar("QuwiState")  -- Récupère l'état actuel de la quête de Quwi
	
    if quwiState == 0 and answer == nil then  
        -- Premier passage : Lancer l'événement d'introduction
        player:startEvent(151)  
        player:setCharVar("QuwiState", 1)  -- Met à jour l'état du joueur à 1 (quête commencée)	
    elseif quwiState == 1 then
	if answer == 1 then
end  

entity.onTalkToQuwi = function(player)
    local quwiState = player:getCharVar("QuwiState")  -- Récupère l'état actuel de la quête de Quwi

    if quwiState == 1 then
        -- Lorsque l'état est 2, l'événement 152 est déclenché
        player:startEvent(152)
	end
end

-- Retour à Roskin pour des instructions supplémentaires (optionnel)
entity.onTalkToRoskin = function(player)
    local roskinState = player:getCharVar("RoskinState")  -- Récupère l'état actuel de la quête de Roskin

    if roskinState == 1 then
        -- Lorsque l'état est 1, l'événement 5129 est déclenché
        player:startEvent(5129)
    end
end

-- Restauration des archives : Ceizak Battlegrounds
entity.onVisitCeizak = function(player)
    player:addKeyItem(2618)  -- Remise de l'objet clé : Record of a thousand lights
    player:startEvent(31)  -- Passer à l'étape suivante
    end
end

-- Restauration des archives : Cirdas Caverns
entity.onVisitCirdas = function(player)
    player:addKeyItem(2616)  -- Remise de l'objet clé : Record of a cavernous foray
    player:startEvent(35)  -- Passer à l'étape suivante
    end
end

-- Visite de la station frontière de Yorcia Weald
entity.onVisitYorcia = function(player)
    player:addKeyItem(2615)  -- Remise de l'objet clé : Record of the generals' foray
    player:startEvent(121)  -- Passer à l'étape suivante
    end
end

-- Visite de Kamihr Drifts
entity.onVisitKamihr = function(player)
    player:addKeyItem(2617)  -- Remise de l'objet clé : Record of the knight in black
    player:startEvent(59)  
    end
end
----------------------------------------------------------------------------------------------------------------- Ou j'en suis rendu
-- CS avec Roskin
entity.onTalkToRoskin = function(player)
    player:addBayld(8000) -- Récompense : 8000 Baylds
    player:startEvent(5130)  -- Activation de la CS
    end
end

-- Rencontre avec Quwi Orihbhe à Rabao
entity.onQuwiQuestion = function(player, npc, answer)
    local quwiState = player:getCharVar("QuwiState")

    -- Première interaction : pose la question
    if quwiState == 0 and answer == nil then  
        player:startEvent(151)                -- Lancer l'événement 151 (question de Quwi)
        player:setCharVar("QuwiState", 1)     -- Met à jour l'état du joueur à 1

    -- Le joueur répond à la question
    elseif quwiState == 1 then
        if answer == 1 then
            player:startEvent(152)            -- Lancer l'événement 152 si réponse 1
            player:setCharVar("QuwiState", 2) -- Met à jour l'état du joueur à 2
        elseif answer == 2 then
            player:startEvent(153)            -- Lancer l'événement 153 si réponse 2
            player:setCharVar("QuwiState", 3) -- Met à jour l'état du joueur à 3
        end
    end
end

entity.onHistoryQuestion = function(player, npc, answer)
    local historyState = player:getCharVar("HistoryState")

    -- Première question (état 0) : Lancer l'événement et attendre la réponse
    if historyState == 0 and answer == nil then
        player:startEvent(37)  -- Lancer l'événement de la première question
        player:setCharVar("HistoryState", 1)  -- Passer à l'état 1 après la première question

    -- Après la première réponse (état 1)
    elseif historyState == 1 then
        if answer == 1 then
            player:setCharVar("HistoryState", 0)  -- Réinitialiser à l'état 0 si la réponse est 1
        elseif answer == 2 then
            player:setCharVar("HistoryState", 0)  -- Réinitialiser à l'état 0 si la réponse est 2
        elseif answer == 3 then
            player:setCharVar("HistoryState", 2)  -- Passer à l'état 2 si la réponse est 3
            player:startEvent(37)  -- Relancer l'événement 37 pour la suite des questions
        end

    -- Branche supplémentaire après la réponse 3 (état 2)
    elseif historyState == 2 then
        if answer == 1 then
            player:setCharVar("HistoryState", 3)  -- Passer à l'état 3 si la réponse est 1
        elseif answer == 2 then
            player:setCharVar("HistoryState", 4)  -- Passer à l'état 4 si la réponse est 2
            player:startEvent(37)  -- Relancer l'événement 37 pour la suite des questions
        end

    -- Branche finale après les réponses des états 3 et 4
    elseif historyState == 3 then
        if answer == 1 then
            player:setCharVar("HistoryState", 5)  -- Passer à l'état 5 si la réponse est 1
        elseif answer == 2 then
            player:setCharVar("HistoryState", 6)  -- Passer à l'état 6 si la réponse est 2
        end
    elseif historyState == 4 then
        if answer == 1 then
            player:setCharVar("HistoryState", 5)  -- Passer à l'état 5 si la réponse est 1
        elseif answer == 2 then
            player:setCharVar("HistoryState", 6)  -- Passer à l'état 6 si la réponse est 2
        end
    end
end


entity.onTalkToRoskin = function(player)
    local soskinState = player:getCharVar("SoskinState")  -- Récupère l'état de l'événement de Soskin
    local lastTalkTime = player:getCharVar("LastTalkTime")  -- Récupère le temps de la dernière interaction (en heures de jeu)
    local currentTime = os.time()  -- Récupère le temps actuel (en secondes depuis l'époque Unix)
    
    -- Utilisation de l'heure actuelle du serveur pour obtenir un format de date précis en jeu
    local currentDate = os.date("*t", currentTime)  -- Obtenir l'heure et la date actuelle du serveur

    -- Convertir le temps en une forme compatible avec l'écoulement du temps en jeu (en heures)
    local currentInGameTime = currentDate.hour + (currentDate.min / 60)  -- Conversion en heures de jeu

    -- Si aucune valeur précédente n'est enregistrée pour la dernière interaction, on enregistre le temps actuel
    if lastTalkTime == 0 then
        player:setCharVar("LastTalkTime", currentInGameTime)
    else
        -- Si plus de 24 heures se sont écoulées (en temps de jeu)
        if currentInGameTime - lastTalkTime >= 24 then
            if soskinState == 0 then
                player:startEvent(5202)  -- Lancer l'événement 5202 si l'état est 0
                player:setCharVar("SoskinState", 1)  -- Mettre à jour l'état de Soskin à 1
                player:setCharVar("LastTalkTime", currentInGameTime)  -- Mettre à jour la dernière interaction
            elseif soskinState == 1 then
                player:startEvent(5203)  -- Lancer l'événement 5203 si l'état est différent de 0
            end

            -- Quand 24 heures se sont écoulées, permettre de lancer l'événement 5204
            if soskinState == 1 then
                player:startEvent(5204)  -- Lancer l'événement 5204
                player:setCharVar("SoskinState", 2)  -- Mettre à jour l'état de Soskin à 2 pour éviter de répéter l'événement
                player:setCharVar("LastTalkTime", currentInGameTime)  -- Mettre à jour la dernière interaction

                -- Ajouter l'item 6155 (par exemple, un objet clé) et 2 Baylds comme récompense
                player:addKeyItem(6155)  -- Ajoute l'objet clé (ID 6155)
                player:addBayld(2)  -- Ajoute 2 Baylds
            end
        else
            -- Si moins de 24 heures se sont écoulées, afficher un message de délai
            player:messageSpecial("Vous devez attendre 24 heures (temps du jeu) avant de pouvoir reparler à Soskin.")
        end
    end
end

return entity
