-----------------------------------
-- Fishing_core
-----------------------------------

local fish_data = require("scripts/globals/fishing/fish_data")
local zone_data = require("scripts/globals/fishing/zones/zone_data")

local FishingCore = {}

-- Constants
local biteDelayMin = 5 -- seconds
local biteDelayMax = 20 -- seconds
local tensionGameDuration = 10

local function isNearWater(player)
    -- Placeholder: This should be refined per zone with specific coordinates
    return true
end

local function getFishInZone(zoneName)
    local zoneFish = zone_data[zoneName:lower()]
    if not zoneFish then return nil end
    return zoneFish[math.random(1, #zoneFish)]
end

function FishingCore.manualFish(player)
    if not isNearWater(player) then
        player:messageSpecial(0, nil, "You must be near water to fish.")
        return
    end
    FishingCore.startFishing(player)
end

function FishingCore.autoFish(player)
    if not isNearWater(player) then return end
    FishingCore.startFishing(player)
end

function FishingCore.startFishing(player)
    player:messageSpecial(0, nil, "You cast your line into the water...")
    player:setLocalVar("is_fishing", 1)

    local delay = math.random(biteDelayMin, biteDelayMax)
    player:timer(delay * 1000, function()
        if player:getLocalVar("is_fishing") ~= 1 then return end
        player:messageSpecial(0, nil, "You feel something tug at your line!")
        FishingCore.beginTensionGame(player)
    end)
end

function FishingCore.beginTensionGame(player)
    local successWindow = os.time() + tensionGameDuration
    player:setLocalVar("fishing_tension_end", successWindow)

    player:messageSpecial(0, nil, "Keep the tension! Fight the fish!")
    player:timer(1000, function()
        FishingCore.checkFishingInput(player)
    end)
end

function FishingCore.checkFishingInput(player)
    if os.time() > player:getLocalVar("fishing_tension_end") then
        FishingCore.resolveCatch(player, true)
    else
        player:timer(1000, function()
            FishingCore.checkFishingInput(player)
        end)
    end
end

function FishingCore.resolveCatch(player, success)
    player:setLocalVar("is_fishing", 0)
    player:setLocalVar("fishing_tension_end", 0)

    if success then
        local zoneName = player:getZoneName():lower():gsub(" ", "_")
        local fishName = getFishInZone(zoneName)
        local fish = fish_data[fishName:lower()]
        local fishId = fish and fish.item_id or 4481 -- fallback to Crayfish

        player:addItem(fishId)
        player:messageSpecial(0, nil, "You caught a " .. (fishName or "fish") .. "!")
        -- TODO: Add skill xp here
    else
        player:messageSpecial(0, nil, "The fish got away...")
    end
end

return FishingCore

