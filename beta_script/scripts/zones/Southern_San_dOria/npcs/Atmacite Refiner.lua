-----------------------------------
-- Zone : Southern San d'Oria
-- NPC : Atmacite Refiner
-- Type : NPC for Voidwatch operations
-- Position : (J-9)
-----------------------------------

---@type TNpcEntity
local entity = {}

-- Constants for Atmacite management
local CRUOR_CURRENCY_ID = "CRUOR"

-- Function to handle interaction with the Atmacite Refiner
entity.onTrigger = function(player, npc)
    local playerCruor = player:getCurrency(CRUOR_CURRENCY_ID)
    local atmaciteCount = player:getAtmaciteCount() -- Assuming there's a method to count active atmacites
    local canTeleport = player:hasAnyStratumAbyssite() -- Check if player has any stratum abyssite for teleportation

    player:startEvent(4000, atmaciteCount, playerCruor, canTeleport and 1 or 0) -- Hypothetical event ID, atmacite count, cruor, can teleport flag
end

-- Function to handle event finishes (player choices)
entity.onEventFinish = function(player, csid, option)
    if csid == 4000 then
        if option == 1 then -- Infuse Atmacite
            local infuseCost = 100 -- Base cost to infuse an atmacite
            if player:getCurrency(CRUOR_CURRENCY_ID) >= infuseCost then
                player:infuseAtmacite() -- Assume this function exists to handle atmacite infusion
                player:removeCurrency(CRUOR_CURRENCY_ID, infuseCost)
                player:messageSpecial(zones[npc:getZoneID()].text.ATMACITE_INFUSED)
            else
                player:messageSpecial(zones[npc:getZoneID()].text.NOT_ENOUGH_CRUOR)
            end
        elseif option == 2 then -- Purge Atmacite
            player:purgeAtmacite() -- Assume this function exists to handle atmacite purging
            player:messageSpecial(zones[npc:getZoneID()].text.ATMACITE_PURGED)
        elseif option == 3 then -- Enrich Atmacite
            local enrichCost = player:getEnrichAtmaciteCost() -- Assume this function calculates the cost based on current atmacite level
            if player:getCurrency(CRUOR_CURRENCY_ID) >= enrichCost then
                player:enrichAtmacite() -- Assume this function exists to handle atmacite enrichment
                player:removeCurrency(CRUOR_CURRENCY_ID, enrichCost)
                player:messageSpecial(zones[npc:getZoneID()].text.ATMACITE_ENRICHED)
            else
                player:messageSpecial(zones[npc:getZoneID()].text.NOT_ENOUGH_CRUOR)
            end
        elseif option == 4 and canTeleport then -- Teleport to Batallia Downs for Voidwatch (assuming this is the only teleport option from San d'Oria)
            player:teleportToVoidwatch("Batallia Downs") -- Assume this function exists to handle teleportation
            player:removeCurrency(CRUOR_CURRENCY_ID, 1000) -- Teleportation cost in Cruor
        end
    end
end

-- Helper functions to be implemented or referenced from core game scripts:

function player:infuseAtmacite()
    -- Logic to infuse an atmacite with the player's current selection or default atmacite
end

function player:purgeAtmacite()
    -- Logic to remove the currently active atmacite
end

function player:enrichAtmacite()
    -- Logic to enrich the player's atmacite, increasing its level
end

function player:getEnrichAtmaciteCost()
    -- Calculate cost based on the atmacite's current level
    -- This should increase as the atmacite's level increases
end

function player:teleportToVoidwatch(zoneName)
    -- Logic to teleport player to the specified Voidwatch area
end

return entity