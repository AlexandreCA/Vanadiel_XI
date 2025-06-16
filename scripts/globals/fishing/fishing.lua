-----------------------------------
-- Fishing
-----------------------------------
local fish_data = require("scripts/globals/fishing/items")
local zone_data = require("scripts/globals/fishing/zones/zones")
-----------------------------------
xi = xi or {}
xi.fishing = xi.fishing or {}
-----------------------------------
local FishingCore = {}

-- Configuration
FishingCore.biteDelayMin = 5
FishingCore.biteDelayMax = 30
FishingCore.tensionGameDuration = 15
FishingCore.requiredTensionScore = 70

-- Vérifie si le joueur est près d'une zone d'eau
local function isNearWater(player)
    return true -- À implémenter avec la logique LSB
end

-- Récupère un poisson/objet aléatoire dans la zone, pondéré par appât
local function getFishInZone(zoneName, baitName, rodName)
    local zoneFish = zone_data[zoneName:lower()]
    if not zoneFish then return nil end

    local validFish = {}
    for _, fishName in ipairs(zoneFish) do
        local fish = fish_data[fishName:lower()]
        if fish and fish.variations[zoneName:lower()] then
            local variation = fish.variations[zoneName:lower()]
            if table.contains(variation.baits, baitName) and table.contains(variation.rods, rodName) then
                table.insert(validFish, fishName)
            end
        end
    end

    if #validFish == 0 then return nil end
    return validFish[math.random(1, #validFish)]
end

-- Calcule et applique un gain de compétence en pêche
local function handleSkillGain(player, fishName, zoneName, success)
    local fishingSkill = player:getSkillLevel(xi.skill.FISHING)
    local fish = fish_data[fishName:lower()]
    local variation = fish and fish.variations[zoneName:lower()]
    local requiredSkill = variation and variation.skill or 0

    local skillDiff = requiredSkill - fishingSkill
    local baseChance = 0.1
    if skillDiff > 0 then
        baseChance = baseChance + (skillDiff * 0.05)
    elseif skillDiff <= -10 then
        baseChance = 0
    end
    baseChance = success and baseChance or baseChance * 0.5

    local maxSkill = 1100 -- 110.0
    if fishingSkill >= maxSkill then return end

    if math.random() < baseChance then
        local skillGain = 1 -- +0.1
        player:setSkillLevel(xi.skill.FISHING, fishingSkill + skillGain)
        player:messageBasic(xi.msg.basic.SKILL_UP, xi.skill.FISHING, fishingSkill + skillGain)
    end
end

-- Vérifie les inputs du joueur pendant le jeu de tension
local function checkFishingInput(player, fishName, zoneName, rodName)
    local fish = fish_data[fishName:lower()]
    local variation = fish and fish.variations[zoneName:lower()]
    if not variation then return false end

    local baseScore = math.random(30, 70)
    local skillBonus = player:getSkillLevel(xi.skill.FISHING) - variation.skill
    local breakChance = variation.break_chance[rodName] or 0.1
    local moonBonus = variation.moon_bonus[xi.moonPhase()] or 1.0
    local weatherBonus = variation.weather_bonus[xi.weather()] or 1.0

    local inputScore = 0
    for _ = 1, FishingCore.tensionGameDuration do
        local input = math.random(-1, 1)
        if input ~= 0 then
            inputScore = inputScore + 10
        end
        if math.random() < breakChance then
            player:messageBasic(xi.msg.basic.FISHING_ROD_BROKE)
            handleSkillGain(player, fishName, zoneName, false)
            return false
        end
    end

    local totalScore = baseScore + inputScore + (skillBonus * 0.5)
    totalScore = totalScore * moonBonus * weatherBonus

    local success = totalScore >= FishingCore.requiredTensionScore
    handleSkillGain(player, fishName, zoneName, success)
    return success
end

-- Résout la capture après le jeu de tension
local function resolveCatch(player, fishName, zoneName)
    local fish = fish_data[fishName:lower()]
    local fishId = fish and fish.item_id or 4481
    if fishId then
        if player:addItem(fishId) then
            player:messageBasic(xi.msg.basic.FISHING_SUCCESS, fishId)
        else
            player:messageBasic(xi.msg.basic.FISHING_FAIL_INV_FULL)
        end
    else
        player:messageBasic(xi.msg.basic.FISHING_FAIL)
    end
end

-- Lance la pêche manuelle
function FishingCore.manualFish(player, baitName, rodName)
    if not isNearWater(player) then
        player:messageBasic(xi.msg.basic.FISHING_NO_WATER)
        return
    end

    local zoneName = player:getZoneName()
    local fishName = getFishInZone(zoneName, baitName, rodName)

    if not fishName then
        player:messageBasic(xi.msg.basic.FISHING_NOTHING_CAUGHT)
        return
    end

    local biteDelay = math.random(FishingCore.biteDelayMin, FishingCore.biteDelayMax)
    player:timer(biteDelay * 1000, function()
        player:messageBasic(xi.msg.basic.FISHING_HOOKED)

        if checkFishingInput(player, fishName, zoneName, rodName) then
            resolveCatch(player, fishName, zoneName)
        else
            player:messageBasic(xi.msg.basic.FISHING_LOST_CATCH)
        end
    end)
end

-- Lance la pêche automatique
function FishingCore.autoFish(player, baitName, rodName)
    while player:getHP() > 0 do
        FishingCore.manualFish(player, baitName, rodName)
        player:timer(5000, function() end)
    end
end

return FishingCore