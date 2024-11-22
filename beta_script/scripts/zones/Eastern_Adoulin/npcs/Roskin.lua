-----------------------------------
-- Area: Eastern Adoulin (257)
-- NPC: Roskin
-- Starts A Thirst for the Ages, A Thirst for the Eons, A Thirst for Eternity, and A Thirst Before Time
-- !pos -34.950 -0.150 -25.140 
-----------------------------------

local zones[xi.zone.EASTERN_ADOULIN] = zoneszones[xi.zone.EASTERN_ADOULIN]

---@type TNpcEntity
local entity = {}

-- Fonction pour la gestion des échanges
entity.onTrade = function(player, npc, trade)
    -- A Thirst for the Ages
    if trade:hasItemQty(12345, 1) and player:getVar("AThirstForTheAgesStarted") == 1 then
        player:tradeComplete()
        player:messageSpecial(zones[xi.zone.EASTERN_ADOULIN].text.A_THIRST_FOR_THE_AGES_COMPLETE)
        player:setVar("AThirstForTheAgesCompleted", 1)
        player:addCurrency("bayld", 10000)
    -- A Thirst for the Eons
    elseif trade:hasItemQty(12346, 1) and player:getVar("AThirstForTheEonsStarted") == 1 then
        player:tradeComplete()
        player:messageSpecial(zones[xi.zone.EASTERN_ADOULIN].text.A_THIRST_FOR_THE_EONS_COMPLETE)
        player:setVar("AThirstForTheEonsCompleted", 1)
        player:addCurrency("bayld", 15000)
    -- A Thirst for Eternity
    elseif trade:hasItemQty(12347, 1) and player:getVar("AThirstForEternityStarted") == 1 then
        player:tradeComplete()
        player:messageSpecial(zones[xi.zone.EASTERN_ADOULIN].text.A_THIRST_FOR_ETERNITY_COMPLETE)
        player:setVar("AThirstForEternityCompleted", 1)
        player:addCurrency("bayld", 20000)
    -- A Thirst Before Time
    elseif trade:hasItemQty(12348, 1) and player:getVar("AThirstBeforeTimeStarted") == 1 then
        player:tradeComplete()
        player:messageSpecial(zones[xi.zone.EASTERN_ADOULIN].text.A_THIRST_BEFORE_TIME_COMPLETE)
        player:setVar("AThirstBeforeTimeCompleted", 1)
        player:addCurrency("bayld", 25000)
    else
        player:messageSpecial(zones[xi.zone.EASTERN_ADOULIN].text.WRONG_ITEM)
    end
end

-- Fonction pour le déclenchement des événements
entity.onTrigger = function(player, npc)
    if player:getVar("AThirstForTheAgesCompleted") == 0 and player:getVar("AThirstForTheAgesStarted") == 1 then
        player:startEvent(10) -- Continuer "A Thirst for the Ages"
    elseif player:getVar("AThirstForTheEonsCompleted") == 0 and player:getVar("AThirstForTheEonsStarted") == 1 then
        player:startEvent(20) -- Continuer "A Thirst for the Eons"
    elseif player:getVar("AThirstForEternityCompleted") == 0 and player:getVar("AThirstForEternityStarted") == 1 then
        player:startEvent(30) -- Continuer "A Thirst for Eternity"
    elseif player:getVar("AThirstBeforeTimeCompleted") == 0 and player:getVar("AThirstBeforeTimeStarted") == 1 then
        player:startEvent(40) -- Continuer "A Thirst Before Time"
    else
        player:startEvent(5) -- Offrir les quêtes disponibles
    end
end

-- Fonction pour la gestion de la fin des événements
entity.onEventFinish = function(player, cszones[xi.zone.EASTERN_ADOULIN], option, npc)
    if cszones[xi.zone.EASTERN_ADOULIN] == 5 then
        if option == 1 then
            player:setVar("AThirstForTheAgesStarted", 1)
            player:messageSpecial(zones[xi.zone.EASTERN_ADOULIN].text.A_THIRST_FOR_THE_AGES_START)
        elseif option == 2 then
            player:setVar("AThirstForTheEonsStarted", 1)
            player:messageSpecial(zones[xi.zone.EASTERN_ADOULIN].text.A_THIRST_FOR_THE_EONS_START)
        elseif option == 3 then
            player:setVar("AThirstForEternityStarted", 1)
            player:messageSpecial(zones[xi.zone.EASTERN_ADOULIN].text.A_THIRST_FOR_ETERNITY_START)
        elseif option == 4 then
            player:setVar("AThirstBeforeTimeStarted", 1)
            player:messageSpecial(zones[xi.zone.EASTERN_ADOULIN].text.A_THIRST_BEFORE_TIME_START)
        end
    elseif cszones[xi.zone.EASTERN_ADOULIN] == 10 then
        player:setVar("AThirstForTheAgesCompleted", 1)
        player:messageSpecial(zones[xi.zone.EASTERN_ADOULIN].text.A_THIRST_FOR_THE_AGES_COMPLETE)
        player:addCurrency("bayld", 10000)
    elseif cszones[xi.zone.EASTERN_ADOULIN] == 20 then
        player:setVar("AThirstForTheEonsCompleted", 1)
        player:messageSpecial(zones[xi.zone.EASTERN_ADOULIN].text.A_THIRST_FOR_THE_EONS_COMPLETE)
        player:addCurrency("bayld", 15000)
    elseif cszones[xi.zone.EASTERN_ADOULIN] == 30 then
        player:setVar("AThirstForEternityCompleted", 1)
        player:messageSpecial(zones[xi.zone.EASTERN_ADOULIN].text.A_THIRST_FOR_ETERNITY_COMPLETE)
        player:addCurrency("bayld", 20000)
    elseif cszones[xi.zone.EASTERN_ADOULIN] == 40 then
        player:setVar("AThirstBeforeTimeCompleted", 1)
        player:messageSpecial(zones[xi.zone.EASTERN_ADOULIN].text.A_THIRST_BEFORE_TIME_COMPLETE)
        player:addCurrency("bayld", 25000)
    end
end

return entity
