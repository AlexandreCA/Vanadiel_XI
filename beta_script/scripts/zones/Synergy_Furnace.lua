-----------------------------------
-- Zone : Bastok Mines
-- Type : Synergy Furnace
-- Position : (J-8)
-----------------------------------

---@type TNpcEntity
local entity = {}

-- Constants for Synergy management in Bastok Markets
local SYNERGY_CRUCIBLE_KEY_ITEM_ID = 1234 
local ITEM_ID_2768 = 2768 
local ITEM_BEHEMOTH_KNIFE = 2769 -- Behemoth Knife ID
local ITEM_BRASS_JADAGNA = 2770 -- Brass Jadagna ID
local SARUTA_ORANGE_ID = 2771
local MORANT_75_ID = 2772
local REVERTANT_ID = 2773
local SYNERGY_CUFFS_ID = 2774
local FEWELL_COST = 100 
local MAX_PRESSURE = 100 
local MAX_IMPURITY = 10 
local TOTAL_FEWELL_FED_ID = 4510 
local RELINQUISH_CLAIM_ID = 4510 
local SYNERGY_RANK_ID = 4512 
local INCOMPATIBLE_APERTURES_ID = 4505 
local ITEM_REQUIRED_ID = 4506 
local SYNERGY_START_ID = 4507 
local SYNERGY_NEW_ARGUMENTS_ID = 4508 
local SELECT_AN_ACTION_ID = 4509 

-- Element types
local ELEMENTS = {"Fire", "Ice", "Wind", "Earth", "Lightning", "Water", "Light", "Dark"}

-- Function to handle interaction with the Synergy Furnace
entity.onTrigger = function(player, npc)
    if not player:hasKeyItem(SYNERGY_CRUCIBLE_KEY_ITEM_ID) then
        return
    else
        player:startEvent(4500)
        local synergyRank = player:getSynergyRank()
        player:startEvent(SYNERGY_RANK_ID, synergyRank)
    end
end

-- Function to handle event finishes (player choices)
entity.onEventFinish = function(player, csid, option, npc)
    if csid == 4500 then
        player:startEvent(SELECT_AN_ACTION_ID)
    elseif csid == SELECT_AN_ACTION_ID then
        if option == 1 then -- Add fewell
            if player:getCurrency("GIL") >= FEWELL_COST then
                player:removeCurrency("GIL", FEWELL_COST)
                player:addSynergyFewell(player:chooseElement())
                player:addKeyItem(TOTAL_FEWELL_FED_ID)
                player:manageMaterialsForSynergy() -- Manage materials for skill up
                player:attemptSynergySkillUp() -- Attempt skill up on every fewell addition
            end
        elseif option == 2 then -- Purge impurity
            if player:getSynergyImpurity() > 0 then
                player:purgeSynergyImpurity()
            end
        elseif option == 3 then -- Release pressure
            if player:getSynergyPressure() > 0 then
                player:releaseSynergyPressure()
            end
        elseif option == 4 then -- Finalize Synergy
            if player:checkSynergyBalance() then
                player:finalizeSynergy()
                -- Don't actually finalize if skill up is the goal, just simulate failure for skill up
                player:failureSynergy()
                player:attemptSynergySkillUp() -- Skill up attempt after simulated failure
            else
                player:failureSynergy()
                player:attemptSynergySkillUp() -- Skill up attempt even on failure to simulate learning from mistakes
            end
        elseif option == 5 then -- Relinquish claim
            player:startEvent(RELINQUISH_CLAIM_ID)
        elseif option == 6 then -- Remove apertures
            player:startEvent(ITEM_REQUIRED_ID)
        end
    elseif csid == ITEM_REQUIRED_ID then
        player:startEvent(4506)
    elseif csid == 4506 then
        if option == 1 then
            if player:hasItem(ITEM_ID_2768) then
                player:removeAllSynergyApertures()
                player:removeItem(ITEM_ID_2768, 1)
                player:startEvent(SYNERGY_START_ID)
            end
        end
    elseif csid == SYNERGY_START_ID then
        if not player:hasRemovableApertures() then
        else
            player:startSynergy()
        end
    elseif csid == RELINQUISH_CLAIM_ID then
        if option == 1 then
            player:relinquishSynergyClaim()
            player:removeKeyItem(SYNERGY_CRUCIBLE_KEY_ITEM_ID)
        end
    elseif csid == SYNERGY_NEW_ARGUMENTS_ID then
        player:startEvent(4509)
    end
end

-- Helper functions for Synergy operations

function player:getSynergyRank()
    return player:getKeyItemCount(SYNERGY_RANK_ID)
end

function player:getSynergyPressure()
    return player.synergyState.pressure or 0
end

function player:getSynergyImpurity()
    return player.synergyState.impurity or 0
end

function player:getSynergyElementalLevels()
    return player.synergyState.elementalBalance or {0,0,0,0,0,0,0,0}
end

function player:addSynergyFewell(element)
    player.synergyState = player.synergyState or {}
    player.synergyState.pressure = math.min(MAX_PRESSURE, (player.synergyState.pressure or 0) + 10)
    player.synergyState.impurity = math.min(MAX_IMPURITY, (player.synergyState.impurity or 0) + 1)

    local balance = player:getSynergyElementalLevels()
    for i, e in ipairs(ELEMENTS) do
        if e == element then
            balance[i] = balance[i] + 1
        end
    end
    player.synergyState.elementalBalance = balance
end

function player:purgeSynergyImpurity()
    player.synergyState.impurity = math.max(0, (player.synergyState.impurity or 0) - 2)
end

function player:releaseSynergyPressure()
    player.synergyState.pressure = math.max(0, (player.synergyState.pressure or 0) - 20)
end

function player:chooseElement()
    return ELEMENTS[math.random(#ELEMENTS)]
end

function player:checkSynergyBalance()
    local balance = player:getSynergyElementalLevels()
    local firstElement = balance[1]
    for i = 2, #balance do
        if balance[i] ~= firstElement then
            return false
        end
    end
    return true
end

function player:finalizeSynergy()
    if player:getSynergyPressure() <= MAX_PRESSURE and player:getSynergyImpurity() <= MAX_IMPURITY then
        -- Success logic here. Add item, update player stats, etc.
    else
        -- Explosion or failure logic here
    end
end

function player:failureSynergy()
    -- Handle failure due to imbalance or explosion
end

function player:relinquishSynergyClaim()
    player.synergyState = {}
end

function player:removeAllSynergyApertures()
    player.synergyState = {}
end

function player:startSynergy()
    player.synergyState = {pressure = 0, impurity = 0, elementalBalance = {0,0,0,0,0,0,0,0}}
end

function player:hasRemovableApertures()
    return player.synergyState and player.synergyState.apertures ~= nil
end

function player:attemptSynergySkillUp()
    if player:hasItem(ITEM_BEHEMOTH_KNIFE) or player:hasItem(ITEM_BRASS_JADAGNA) then
        if player:hasItem(MORANT_75_ID) then
            -- Simulate the thwacking process for skill up
            local skillUpChance = player:hasItem(SYNERGY_CUFFS_ID) and 0.2 or 0.1  -- Bonus if wearing Synergy Cuffs
            if math.random() < skillUpChance then
                local currentSkill = player:getSynergyRank()
                player:setSynergyRank(currentSkill + 0.1) -- Increase skill by small amount
            end
            
            -- Use Revertant if available to reset without material loss
            if player:hasItem(REVERTANT_ID) then
                player:removeItem(REVERTANT_ID, 1)
                player:startSynergy() -- Reset Synergy state
            end
        else
            -- Inform player they need Morant 75 for skill up
        end
    else
        -- Inform player they need a Behemoth Knife or Brass Jadagna
    end
end

function player:setSynergyRank(newRank)
    -- Here you would set the new Synergy Rank for the player
    -- This might involve updating a database or player state in the game
    player:setKeyItemCount(SYNERGY_RANK_ID, newRank)
end

function player:manageMaterialsForSynergy()
    if player:hasItem(SARUTA_ORANGE_ID, 4) then
        -- Simulate crafting Orange Juice for Cinders
        player:removeItem(SARUTA_ORANGE_ID, 4)
        player:addCurrency("CINDERS", 125)
    else
        -- Inform player they need Saruta Oranges
    end
end

return entity