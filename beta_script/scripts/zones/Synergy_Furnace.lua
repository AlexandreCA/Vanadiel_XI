-----------------------------------
-- Zone : Bastok Markets
-- NPC : Synergy Furnace.
-- Type : NPC for Synergy operations
-- Position : (G-8) (Example position)
-----------------------------------

---@type TNpcEntity
local entity = {}

-- Constants for Synergy management in Bastok Markets
local SYNERGY_CRUCIBLE_KEY_ITEM_ID = 2614 -- Hypothetical Key Item ID for Synergy Crucible
local SYNERGY_FURNACE_ID = 1 -- Example ID for Synergy Furnace interaction in Bastok
local FEWELL_COST_PER = 100 -- Cost per fewell in gil
local TRAINING_LEVEL_INCREMENT = 5 -- Synergy training is available every 5 levels

-- Function to handle interaction with the Synergy Engineer in Bastok
entity.onTrigger = function(player, npc)
    if not player:hasKeyItem(SYNERGY_CRUCIBLE_KEY_ITEM_ID) then
        player:startEvent(7000) -- Event to obtain Synergy Crucible
    else
        local currentSynergySkill = player:getSynergySkill()
        local fewellStock = player:getFewellStock()
        local canTrain = player:canReceiveSynergyTraining()
        player:startEvent(7001, currentSynergySkill, fewellStock, canTrain and 1 or 0) -- Interaction with Synergy system
    end
end

-- Function to handle event finishes (player choices)
entity.onEventFinish = function(player, csid, option, npc)
    if csid == 7000 then
        if option == 1 then -- Obtain Synergy Crucible
            player:addKeyItem(SYNERGY_CRUCIBLE_KEY_ITEM_ID)
            player:messageSpecial(zones[xi.zone.BASTOK_MARKETS].text.OBTAINED_SYNERGY_CRUCIBLE)
        end
    elseif csid == 7001 then
        if option == 1 then -- Restock fewell
            local fewellToRestock = 10 -- Example amount to restock
            local gilBalance = player:getCurrency("GIL")
            if gilBalance >= FEWELL_COST_PER * fewellToRestock then
                player:removeCurrency("GIL", FEWELL_COST_PER * fewellToRestock)
                player:restockFewell(fewellToRestock)
                player:messageSpecial(zones[xi.zone.BASTOK_MARKETS].text.FEWELL_RESTOCKED, fewellToRestock)
            else
                player:messageSpecial(zones[xi.zone.BASTOK_MARKETS].text.NOT_ENOUGH_GIL)
            end
        elseif option == 2 and player:canReceiveSynergyTraining() then -- Receive Synergy training
            player:receiveSynergyTraining()
            player:messageSpecial(zones[xi.zone.BASTOK_MARKETS].text.SYNERGY_TRAINING_RECEIVED)
        elseif option == 3 then -- Use Synergy Furnace
            player:setSynergyFurnaceInteraction(SYNERGY_FURNACE_ID)
            player:messageSpecial(zones[xi.zone.BASTOK_MARKETS].text.USING_SYNERGY_FURNACE)
        end
    end
end

-- Helper functions specific to Bastok Markets (assuming some are defined elsewhere or in core game scripts):

function player:getSynergySkill()
    -- Returns the player's current Synergy skill level
end

function player:getFewellStock()
    -- Returns the player's current fewell stock
end

function player:restockFewell(amount)
    -- Adds the specified amount of fewell to the player's stock
end

function player:canReceiveSynergyTraining()
    -- Checks if the player can receive training based on their current Synergy level
    return (player:getSynergySkill() % TRAINING_LEVEL_INCREMENT) == 0
end

function player:receiveSynergyTraining()
    -- Provides training which might increase Synergy skill or unlock new recipes
end

function player:setSynergyFurnaceInteraction(furnaceId)
    -- Sets up the interaction with the Synergy Furnace, potentially leading to another set of options or a different script for crafting
end

return entity