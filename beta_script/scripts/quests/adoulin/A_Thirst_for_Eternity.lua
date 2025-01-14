-----------------------------------
-- Zone : Eastern Adoulin (257)
-- NPC : Roskin
-- Type : Quête A Thirst for Eternity
-- Position : !pos -36.5290 -0.1500 -24.5645 257
-----------------------------------

---@type TNpcEntity
local entity = {}

-- Activation de la quête avec Roskin
entity.onTalkToRoskin = function(player)
    if player:hasCompletedQuest("A Thirst for the Eons") then
        player:startEvent(539)  -- Activation de la quête (Event ID: 539)
    else
        player:messageSpecial(zones[player:EASTERN_ADOULIN()].text.ROSKIN_QUEST_REQUIREMENTS_NOT_MET)  -- Message d'erreur si les prérequis ne sont pas remplis
    end
end

-- Recevoir Elder wooden box de Roskin
entity.onReceiveElderWoodenBox = function(player)
    player:addKeyItem(2612)  -- Remise de l'objet clé : Elder wooden box
    player:startEvent(540)  -- Cutscene de réception de l'objet (Event ID: 540)
end

-- Rencontre avec Palomel pour obtenir Imprint device S
entity.onTalkToPalomel = function(player)
    player:addKeyItem(2614)  -- Remise de l'objet clé : Imprint device S
    player:startEvent(541)  -- Cutscene avec Palomel (Event ID: 541)
end

-- Rencontre avec Quwi Orihbhe pour une cutscene
entity.onTalkToQuwiOrihbhe = function(player)
    player:startEvent(542)  -- Cutscene avec Quwi Orihbhe (Event ID: 542)
end

-- Utilisation de l'Imprint device S dans différents lieux (Ceizak Battlegrounds, Cirdas Caverns, Yorcia Weald, Kamihr Drifts)
entity.onUseImprintDeviceS = function(player)
    -- Pour chaque emplacement, vous pouvez avoir des événements spécifiques ou un seul événement pour tous les sites.
    -- Supposons que chaque lieu a son propre événement:
    player:startEvent(543)  -- Ceizak Battlegrounds (Event ID: 543)
    player:startEvent(544)  -- Cirdas Caverns (Event ID: 544)
    player:startEvent(545)  -- Yorcia Weald (Event ID: 545)
    player:startEvent(546)  -- Kamihr Drifts (Event ID: 546)
end

-- Retour à Roskin pour remettre les items et finir la quête
entity.onReturnToRoskin = function(player)
    if player:hasKeyItem(2615) and player:hasKeyItem(2616) and player:hasKeyItem(2617) and player:hasKeyItem(2618) then
        player:delKeyItem(2615)  -- Suppression de Record of a thousand lights
        player:delKeyItem(2616)  -- Suppression de Record of a cavernous foray
        player:delKeyItem(2617)  -- Suppression de Record of the generals' foray
        player:delKeyItem(2618)  -- Suppression de Record of the knight in black
        player:startEvent(547)  -- Cutscene de fin de quête (Event ID: 547)
    else
        player:messageSpecial(zones[player:EASTERN_ADOULIN()].text.NOT_ENOUGH_KEY_ITEMS)  -- Message si tous les objets clés ne sont pas collectés
    end
end

return entity