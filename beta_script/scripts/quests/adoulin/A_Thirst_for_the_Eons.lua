-----------------------------------
-- Zone : Eastern Adoulin (257)
-- NPC : Roskin
-- Type : Quête A Thirst for the Eons (non répétable)
-- !pos -36.5290 -0.1500 -24.5645 257
-----------------------------------

---@type TNpcEntity
local entity = {}

-- Fonction appelée lors de l'échange (trade) avec l'NPC
entity.onTrade = function(player, npc, trade)
    -- Vérifier si le joueur a terminé la quête "Order Up"
    if not player:hasCompletedQuest("Order Up") then
        player:messageSpecial(zones[player:EASTERN_ADOULIN()].text.ORDER_UP_REQUIRED)
        return
    end

    -- Vérifier si le joueur a donné l'objet "Ulbuconut Milk" ou "Ulbuconut Milk +1"
    if trade:hasItemQty(5976, 1) or trade:hasItemQty(5977, 1) then
        -- Vérifier si le joueur a le Key Item "Dictum on Colonization"
        if player:hasKeyItem(2587 ) then
            if player:getVar("RoskinQuestCompletedEons") == 1 then
                player:messageSpecial(zones[player:EASTERN_ADOULIN()].text.ROSKIN_QUEST_ALREADY_COMPLETED_EONS)
                return
            end

            trade:confirm()

            -- Ajouter les Key Items nécessaires pour la quête
            player:addKeyItem(2580)  -- Copy of "Wrath of the Land"
            player:addKeyItem(2584)  -- Report of a Sorcerous Nation
            player:addKeyItem(2585)  -- Copy of "The Verdancy"
            player:addKeyItem(2586)  -- Giant Sheep Export Record
            player:addKeyItem(2587)  -- Dictum on Colonization
            player:addKeyItem(2269)  -- Copy of "Adoulin's Patroness" (optionnel pour CS amusant)
            player:messageSpecial(zones[player:EASTERN_ADOULIN()].text.KEYITEMS_RECEIVED_EONS)
            player:startEvent(6)  -- ID de la cutscene associée pour choisir les items
            player:setVar("RoskinLastInteraction", os.time())
        else
            player:messageSpecial(zones[player:EASTERN_ADOULIN()].text.MISSING_DICTUM)
        end
    else
        player:messageSpecial(zones[player:EASTERN_ADOULIN()].text.WRONG_ITEM)
    end
end

-- Fonction appelée lorsque le joueur interagit avec l'NPC
entity.onTrigger = function(player, npc)
    -- Vérifier si le joueur a terminé la quête "Order Up"
    if not player:hasCompletedQuest("Order Up") then
        player:messageSpecial(zones[player:EASTERN_ADOULIN()].text.ORDER_UP_REQUIRED)
        return
    end

    -- Vérifier si le joueur a le Key Item "Dictum on Colonization"
    if player:hasKeyItem(19616) then
        if player:getVar("RoskinQuestCompletedEons") == 1 then
            player:messageSpecial(zones[player:EASTERN_ADOULIN()].text.ROSKIN_QUEST_ALREADY_COMPLETED_EONS)
            return
        end

        if not player:hasKeyItem(2580) then  -- Copy of "Wrath of the Land"
            -- Ajouter les Key Items nécessaires pour la quête
            player:addKeyItem(2580)  -- Copy of "Wrath of the Land"
            player:addKeyItem(2584)  -- Report of a Sorcerous Nation
            player:addKeyItem(2585)  -- Copy of "The Verdancy"
            player:addKeyItem(2586)  -- Giant Sheep Export Record
            player:addKeyItem(2587)  -- Dictum on Colonization
            player:addKeyItem(2269)  -- Copy of "Adoulin's Patroness" (optionnel pour CS amusant)
            player:messageSpecial(zones[player:EASTERN_ADOULIN()].text.KEYITEMS_RECEIVED_EONS)
            player:startEvent(6)  -- ID de la cutscene associée pour choisir les items
            player:setVar("RoskinLastInteraction", os.time())
        else
            player:messageSpecial(zones[player:EASTERN_ADOULIN()].text.ALREADY_HAS_KEYITEMS_EONS)
        end
    else
        player:messageSpecial(zones[player:EASTERN_ADOULIN()].text.MISSING_DICTUM)
    end
end

-- Fonction appelée après la fin de l'événement (cutscene)
entity.onEventFinish = function(player, csid, option, npc)
    if csid == 6 then  -- ID de la cutscene pour choisir les items
        -- Le joueur a choisi les Key Items importants (ils sont ajoutés dans l'événement précédent)
        -- Récompenses après avoir choisi les items
        -- Le joueur doit maintenant attendre jusqu'au prochain jour de jeu

        -- Calcul du temps restant pour le prochain jour de jeu
        local currentTime = os.time()
        local gameDay = math.floor(currentTime / 1440)  -- Calcul du jour de jeu en utilisant 1440 minutes par jour
        local nextGameDay = (gameDay + 1) * 1440  -- Prochain jour de jeu en secondes
        local timeToWait = nextGameDay - currentTime  -- Temps restant pour le prochain jour de jeu

        -- Ajouter un délai de temps avant de pouvoir interagir à nouveau avec Roskin
        player:setVar("RoskinNextInteraction", currentTime + timeToWait)

        -- Message indiquant que le joueur doit attendre jusqu'au prochain jour de jeu
        player:messageSpecial(zones[player:EASTERN_ADOULIN()].text.ROSKIN_WAIT_NEXT_DAY)
    end
end

-- Fonction pour vérifier l'interaction après le délai
entity.onTriggerAfterWait = function(player, npc)
    local currentTime = os.time()
    local nextInteractionTime = player:getVar("RoskinNextInteraction")

    if currentTime >= nextInteractionTime then
        -- Déterminer le rapport du joueur et accorder les récompenses
        local reportQuality = player:getVar("RoskinReportQuality")

        if reportQuality == 1 then
            player:addCurrency("bayld", 5000)
            player:messageSpecial(zones[player:EASTERN_ADOULIN()].text.PERFECT_REPORT)
        else
            player:addCurrency("bayld", 2)
            player:messageSpecial(zones[player:EASTERN_ADOULIN()].text.SHODDY_REPORT)
        end

        -- Récompenses supplémentaires
        player:addExperience(2000)
        player:addCurrency("bayld", 1000)
        player:messageSpecial(zones[player:EASTERN_ADOULIN()].text.REWARDS_RECEIVED)

        -- Optionnel: Récompense de 10000 bayld pour une performance exceptionnelle
        if reportQuality == 2 then
            player:addCurrency("bayld", 10000)
            player:messageSpecial(zones[player:EASTERN_ADOULIN()].text.EXTRA_BAYLD)
        end

        -- Réinitialisation des variables de quête
        player:setVar("RoskinQuestCompletedEons", 1)
    else
        player:messageSpecial(zones[player:EASTERN_ADOULIN()].text.WAIT_UNTIL_NEXT_GAME_DAY)
    end
end

return entity
