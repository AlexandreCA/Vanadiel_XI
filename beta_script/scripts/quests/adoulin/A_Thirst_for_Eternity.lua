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
    player:startEvent(5124)  -- Activation de la quête 
end

-- Question de Roskin pour l'activation
entity.onRoskinQuestion = function(player, npc, answer)
    local roskinState = player:getCharVar("RoskinState")
    if roskinState == 0 and answer == nil then  
       player:startEvent(5125)
       player:setCharVar("RoskinState", 1) -- Met à jour l'état du joueur
    elseif roskinState == 1
    if answer == 1 then
       player:addKeyItem(2613)  -- Remise de l'objet clé : Elder Wooden Box   
    end
end

-- Étape de la quête : Rencontre avec Palomel
entity.onTalkToPalomel = function(player, npc, answer)  
   local palomelState = player:getCharVar("PalomelState")
   if palomelState == 0 and answer == nil then
       player:startEvent(5126)
       player:setCharVar("PalomelState", 1) -- Met à jour l'état du joueur
   elseif palomelState == 1 
   if answer == 3 then
   elseif answer == 2 then
       player:addKeyItem(5678)  -- Remise de l'objet clé : Imprint Device S
       player:startEvent(5127)
   end   
elseif palomelState == 2 and answer == nil then
       player:startEvent(5128)
   end	
end

-- Rencontre avec Quwi Orihbhe à Rabao 
entity.onQuwiQuestion = function(player, npc, answer)
    local quwiState = player:getCharVar("QuwiState")
    if quwiState == 0 and answer == nil then  
        player:startEvent(151)
        player:setCharVar("quwiState", 1) -- Met à jour l'état du joueur
    elseif quwiState == 1
    if answer == 2 then
    end
end    

entity.onQuwiQuestion = function(player, npc, answer)
    local quwiState = player:getCharVar("QuwiState")
    if quwiState == 0 and answer == nil then  
       player:setCharVar("quwiState", 1) -- Met à jour l'état du joueur
    elseif quwiState == 1
    if answer == 1 then    
    end
end

-- Retour à Roskin pour des instructions supplémentaires (optionnel)
entity.onReturnToRoskin = function(player)
    player:startEvent(5129)  -- Roskin vous parle de l'utilisation de l'appareil dans diverses zones
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

-- CS avec Roskin
entity.onTalkToRoskin = function(player)
    player:addBayld(8000) -- Récompense : 8000 Baylds
    player:startEvent(5130)  -- Activation de la CS
    end
end

return entity