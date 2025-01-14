-----------------------------------
-- Zone : Bastok Mines
-- NPC : Synergy Engineer
-- Type : NPC for Synergy Support 
-- Position : (J-8)
-----------------------------------
---@type TNpcEntity
local entity = {}

-- Constants for Synergy Engineer Interaction
local SYNERGY_CRUCIBLE_KEY_ITEM_ID = 1234 -- Key Item ID for Synergy Crucible
local COST_SYNERGY_CRUCIBLE = 100 -- Cost of Synergy Crucible in gil
local COST_MORDANT = 500 -- Cost of one Mordant in gil
local COST_REVERTANT = 1000 -- Cost of one Revertant in gil
local COST_FEWEL_REPLENISH = 100 -- Cost to replenish one fewell
local MORANT_75_ID = 2807 -- Updated ID for Mordant 75
local REVERTANT_ID = 2768 -- Updated ID for Revertant
local SARUTA_ORANGE_ID = 4361 -- ID for Saruta Orange
local ELEMENTS = {"Fire", "Ice", "Wind", "Earth", "Lightning", "Water", "Light", "Dark"}

-- Constants for Synergy management in Bastok Markets
local SYNERGY_FURNACE_INTERACTION_ID = 4500 -- Event ID for interacting with Synergy Furnace
local TOTAL_FEWELL_FED_ID = 4501 -- Key Item ID to track total fewell fed
local RELINQUISH_CLAIM_ID = 4502 -- Key Item ID for relinquishing the claim
local SYNERGY_RANK_ID = 4512 -- Key Item ID for Synergy Rank
local INCOMPATIBLE_APERTURES_ID = 4505 -- Key Item ID for incompatible apertures message
local ITEM_REQUIRED_ID = 4506 -- Event ID for checking and using item ID 2768 to remove apertures
local SYNERGY_START_ID = 4507 -- Event ID for starting Synergy after removing apertures
local SYNERGY_NEW_ARGUMENTS_ID = 4508 -- Event ID for informing about new arguments
local SELECT_AN_ACTION_ID = 4509 -- Event ID for menu "Select an action"

local EVENT_SYNERGY_ENGINEER = 11001 -- Event ID for Synergy Engineer interaction (both 11001 and 11002)

-- Function to handle interaction with the Synergy Engineer
entity.onTrigger = function(player, npc)
    -- Since both IDs give the same result, we'll use just one
    player:startEvent(EVENT_SYNERGY_ENGINEER)
end

-- Function to handle event finishes with Synergy Engineer (player choices)
entity.onEventFinish = function(player, csid, option, npc)
    if csid == EVENT_SYNERGY_ENGINEER then
        if not player:hasKeyItem(SYNERGY_CRUCIBLE_KEY_ITEM_ID) then
            if option == 1 then -- Player accepts to purchase Synergy Crucible
                if player:getCurrency("GIL") >= COST_SYNERGY_CRUCIBLE then
                    player:removeCurrency("GIL", COST_SYNERGY_CRUCIBLE)
                    player:addKeyItem(SYNERGY_CRUCIBLE_KEY_ITEM_ID)
                end
            end
        else
            if option == 1 then -- Buy Mordant
                if player:getCurrency("GIL") >= COST_MORDANT then
                    player:removeCurrency("GIL", COST_MORDANT)
                    player:addItem(MORANT_75_ID, 1)
                end
            elseif option == 2 then -- Buy Revertant
                if player:getCurrency("GIL") >= COST_REVERTANT then
                    player:removeCurrency("GIL", COST_REVERTANT)
                    player:addItem(REVERTANT_ID, 1)
                end
            elseif option == 3 then -- Replenish Fewell
                if player:getCurrency("GIL") >= COST_FEWEL_REPLENISH * #ELEMENTS then -- Assuming full replenish for all elements
                    player:removeCurrency("GIL", COST_FEWEL_REPLENISH * #ELEMENTS)
                    for _, element in ipairs(ELEMENTS) do
                        player:addSynergyFewell(element, 99) -- Replenish each element to max (99 is an example)
                    end
                end
            elseif option == 4 then -- Learn new Synergy Recipes
                -- Here you would add logic to teach new recipes based on player's synergy skill
            end
        end
    end
end

-- Helper functions for Synergy Engineer operations

function player:addSynergyFewell(element, amount)
    -- Assuming this function exists elsewhere, it adds fewell to the player's crucible
end

return entity