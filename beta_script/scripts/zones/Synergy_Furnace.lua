-----------------------------------
-- Zone : Bastok Markets
-- NPC : Synergy Furnace
-- Type : NPC for Synergy operations
-- Position : (G-8) (Example position)
-----------------------------------

---@type TNpcEntity
local entity = {}

-- Constants for Synergy management in Bastok Markets
local SYNERGY_CRUCIBLE_KEY_ITEM_ID = 1234 -- Key Item ID for Synergy Crucible
local FEWELL_COST = 100 -- Cost per fewell in gil
local MAX_PRESSURE = 100 -- Maximum pressure before explosion
local MAX_IMPURITY = 10 -- Maximum impurity level

-- Function to handle interaction with the Synergy Furnace
entity.onTrigger = function(player, npc)
    if not player:hasKeyItem(SYNERGY_CRUCIBLE_KEY_ITEM_ID) then
        player:startEvent(7000) -- Event to obtain Synergy Crucible
    else
        local synergyStatus = {
            pressure = player:getSynergyPressure(),
            impurity = player:getSynergyImpurity(),
            elementalLevels = player:getSynergyElementalLevels(),
        }
        player:startEvent(7001, synergyStatus.pressure, synergyStatus.impurity, synergyStatus.elementalLevels)
    end
end

-- Function to handle event finishes (player choices)
entity.onEventFinish = function(player, csid, option, npc)
    if csid == 7000 and option == 1 then -- Obtain Synergy Crucible
        player:addKeyItem(SYNERGY_CRUCIBLE_KEY_ITEM_ID)
        player:messageSpecial(zones[xi.zone.BASTOK_MARKETS].text.OBTAINED_SYNERGY_CRUCIBLE)
    elseif csid == 7001 then
        if option == 1 then -- Add fewell
            local gilBalance = player:getCurrency("GIL")
            if gilBalance >= FEWELL_COST then
                player:removeCurrency("GIL", FEWELL_COST)
                player:addSynergyFewell()
                player:messageSpecial(zones[xi.zone.BASTOK_MARKETS].text.FEWELL_ADDED)
            else
                player:messageSpecial(zones[xi.zone.BASTOK_MARKETS].text.NOT_ENOUGH_GIL)
            end
        elseif option == 2 then -- Purge impurity
            if player:getSynergyImpurity() > 0 then
                player:purgeSynergyImpurity()
                player:messageSpecial(zones[xi.zone.BASTOK_MARKETS].text.IMPURITY_PURGED)
            else
                player:messageSpecial(zones[xi.zone.BASTOK_MARKETS].text.NO_IMPURITY)
            end
        elseif option == 3 then -- Release pressure
            if player:getSynergyPressure() > 0 then
                player:releaseSynergyPressure()
                player:messageSpecial(zones[xi.zone.BASTOK_MARKETS].text.PRESSURE_RELEASED)
            else
                player:messageSpecial(zones[xi.zone.BASTOK_MARKETS].text.NO_PRESSURE)
            end
        elseif option == 4 then -- Finalize Synergy
            local success = player:finalizeSynergy()
            if success then
                player:messageSpecial(zones[xi.zone.BASTOK_MARKETS].text.SYNERGY_SUCCESS)
            else
                player:messageSpecial(zones[xi.zone.BASTOK_MARKETS].text.SYNERGY_FAILURE)
            end
        end
    end
end

-- Helper functions for Synergy operations
function player:getSynergyPressure()
    -- Returns the current pressure level of the furnace
end

function player:getSynergyImpurity()
    -- Returns the current impurity level of the furnace
end

function player:getSynergyElementalLevels()
    -- Returns the elemental levels of the furnace
end

function player:addSynergyFewell()
    -- Adds fewell to the furnace and adjusts elemental levels
end

function player:purgeSynergyImpurity()
    -- Reduces impurity level in the furnace
end

function player:releaseSynergyPressure()
    -- Reduces pressure in the furnace
end

function player:finalizeSynergy()
    -- Determines success or failure of the Synergy process
    -- Returns true if successful, false otherwise
end

return entity
