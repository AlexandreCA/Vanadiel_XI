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

-- Vérifie la fatigue de pêche (200 captures/jour)
local function checkFishingFatigue(player)
    local lastReset = player:getVar("FishingFatigueReset") or 0
    local currentTime = os.time()
    if currentTime - lastReset >= 86400 then
        player:setVar("FishingFatigueCount", 0)
        player:setVar("FishingFatigueReset", currentTime)
    end
    local fatigueCount = player:getVar("FishingFatigueCount") or 0
    if fatigueCount >= 200 then
        player:messageBasic(xi.msg.basic.FISHING_FATIGUE, 0, 0, 0, "Vous avez atteint la limite quotidienne de pêche !")
        return false
    end
    return true
end

-- Calcule le bonus de compétence (par exemple, Fisherman's Tunica)
local function getFishingSkillBonus(player)
    local bonus = 0
    if player:hasItem(13759) then -- Fisherman's Tunica
        bonus = bonus + 40 -- +4.0
    end
    return bonus
end

-- Récupère un poisson/objet aléatoire dans la zone
local function getFishInZone(zoneName, baitName, rodName)
    local zoneFish = zones[zoneName:lower()]
    if not zoneFish then return nil end

    local validFish = {}
    for _, fishName in ipairs(zoneFish) do
        local fish = items[fishName:lower()]
        if fish and fish.variations[zoneName:lower()] then
            local variation = fish.variations[zoneName:lower()]
            if table.contains(variation.baits, baitName) and table.contains(variation.rods, rodName) then
                table.insert(validFish, fishName)
            end
        end
    end

    if #validFish == 0 then
        player:messageBasic(xi.msg.basic.FISHING_NOTHING_CAUGHT, 0, 0, 0, "Appât ou canne inadapté !")
        return nil
    end
    return validFish[math.random(1, #validFish)]
end

-- Vérifie et notifie les progrès de rang
local function checkRankProgress(player, fishingSkill)
    local rankThresholds = {
        [xi.craftRank.NOVICE] = 0,
        [xi.craftRank.APPRENTICE] = 280, -- 28.0
        [xi.craftRank.JOURNEYMAN] = 480, -- 48.0
        [xi.craftRank.ARTISAN] = 680, -- 68.0
        [xi.craftRank.EXPERT] = 880, -- 88.0
    }
    local currentRank = player:getRank(xi.guild.FISHING) or xi.craftRank.NOVICE
    for rank, threshold in pairs(rankThresholds) do
        if fishingSkill >= threshold and currentRank < rank then
            player:messageSpecial(xi.msg.basic.FISHING_RANK_UP, 0, 0, 0, "Parlez à Thubu Parohren pour passer au rang suivant !")
            break
        end
    end
end

-- Calcule et applique un gain de compétence en pêche
local function handleSkillGain(player, fishName, zoneName, success)
    local fishingSkill = player:getSkillLevel(xi.skill.FISHING) + getFishingSkillBonus(player)
    local fish = items[fishName:lower()]
    local variation = fish and fish.variations[zoneName:lower()]
    local requiredSkill = variation and variation.skill or 0

    local skillDiff = requiredSkill - fishingSkill
    local baseChance = 0.15 -- Augmenté pour refléter la fréquence des skill-ups
    if skillDiff > 0 then
        baseChance = baseChance + (skillDiff * 0.05)
    elseif skillDiff <= -10 then
        baseChance = 0
    end
    baseChance = success and baseChance or baseChance * 0.5
    if player:hasItem(15554) then -- Pelican Ring
        baseChance = baseChance * 1.1
    end

    local maxSkill = 1100 -- 110.0
    if fishingSkill >= maxSkill then return end

    if math.random() < baseChance then
        local skillGain = 1 -- +0.1
        player:setSkillLevel(xi.skill.FISHING, player:getSkillLevel(xi.skill.FISHING) + skillGain)
        player:messageBasic(xi.msg.basic.SKILL_UP, xi.skill.FISHING, fishingSkill + skillGain)
        checkRankProgress(player, fishingSkill + skillGain)
    end
end

-- Vérifie les inputs du joueur pendant le jeu de tension
local function checkFishingInput(player, fishName, zoneName, rodName)
    local fish = items[fishName:lower()]
    local variation = fish and fish.variations[zoneName:lower()]
    if not variation then return false end

    local baseScore = math.random(30, 70)
    local skillBonus = (player:getSkillLevel(xi.skill.FISHING) + getFishingSkillBonus(player)) - variation.skill
    local breakChance = variation.break_chance[rodName] or 0.1
    local moonBonus = variation.moon_bonus[xi.moonPhase()] or 1.0
    local weatherBonus = variation.weather_bonus[xi.weather()] or 1.0
    local timeBonus = variation.time_bonus[xi.time()] or 1.0 -- Ajouté

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
    totalScore = totalScore * moonBonus * weatherBonus * timeBonus
    local success = totalScore >= FishingCore.requiredTensionScore
    handleSkillGain(player, fishName, zoneName, success)
    return success
end

-- Résout la capture après le jeu de tension
local function resolveCatch(player, fishName, zoneName)
    local fish = items[fishName:lower()]
    local fishId = fish and fish.item_id or 4481
    if fishId then
        if player:addItem(fishId) then
            player:setVar("FishingFatigueCount", player:getVar("FishingFatigueCount") + 1)
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
    if not checkFishingFatigue(player) then return end
    if not isNearWater(player) then
        player:messageBasic(xi.msg.basic.FISHING_NO_WATER)
        return
    end

    local zoneName = player:getZoneName()
    local fishName = getFishInZone(zoneName, baitName, rodName)
    if not fishName then return end

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
    while player:getHP() > 0 and checkFishingFatigue(player) do
        FishingCore.manualFish(player, baitName, rodName)
        player:timer(5000, function() end)
    end
end

return FishingCore