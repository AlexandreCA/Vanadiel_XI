-----------------------------------
-- Fishing
-----------------------------------
local fish_data = require("scripts/globals/fishing/items")
local zone_data = require("scripts/globals/fishing/zones/zones")
-----------------------------------
xi = xi or {}
xi.fishing = xi.fishing or {}

xi.fishing.areas = {}

local function loadFishingAreas()
    local query = "SELECT zoneid, areaid, name, center_x, center_y, center_z, bound_radius FROM fishing_area"
    local result = sql:query(query)

    for _, row in ipairs(result) do
        local zoneId = tonumber(row.zoneid)
        xi.fishing.areas[zoneId] = xi.fishing.areas[zoneId] or {}

        table.insert(xi.fishing.areas[zoneId], {
            name = row.name,
            x = tonumber(row.center_x),
            y = tonumber(row.center_y),
            z = tonumber(row.center_z),
            radius = tonumber(row.bound_radius),
            default = false -- Pas d'is_default explicite, à ajuster si nécessaire
        })
    end
end

loadFishingAreas()

local function getWaterBody(player)
    local zoneId = player:getZoneID()
    local areas = xi.fishing.areas[zoneId]
    if not areas then return nil end

    local px, py, pz = player:getXPos(), player:getYPos(), player:getZPos()

    for _, area in ipairs(areas) do
        local dx, dy, dz = px - area.x, py - area.y, pz - area.z
        if math.sqrt(dx * dx + dy * dy + dz * dz) <= area.radius then
            return area.name
        end
    end

    if #areas > 0 then
        return areas[1].name
    end

    return nil
end

local function isNearWater(player)
    local zoneId = player:getZoneID()
    local areas = xi.fishing.areas[zoneId]
    if not areas then return false end

    local px, py, pz = player:getXPos(), player:getYPos(), player:getZPos()

    for _, area in ipairs(areas) do
        local dx, dy, dz = px - area.x, py - area.y, pz - area.z
        if math.sqrt(dx * dx + dy * dy + dz * dz) <= area.radius then
            return true
        end
    end

    return false
end

xi.fishing.zones = zone_data
xi.fishing.items = fish_data
-----------------------------------
local FishingCore = {}

FishingCore.biteDelayMin = 5
FishingCore.biteDelayMax = 30
FishingCore.tensionGameDuration = 15
FishingCore.requiredTensionScore = 70

local function checkFishingFatigue(player)
    local lastReset = player:getVar("FishingFatigueReset") or 0
    local currentTime = os.time()
    if currentTime - lastReset >= 86400 then
        player:setVar("FishingFatigueCount", 0)
        player:setVar("FishingFatigueReset", currentTime)
    end
    local fatigueCount = player:getVar("FishingFatigueCount") or 0
    if fatigueCount >= 200 then
        player:messageBasic(xi.msg.basic.FISHING_FATIGUE, 0, 0, 0, "")
        return false
    end
    return true
end

local function isContestActive()
    local query = "SELECT status FROM fishing_contest WHERE starttime <= " .. os.time() .. " AND nextstagetime > " .. os.time()
    local result = sql:query(query)
    return #result > 0 and result[1].status == 1 -- Supposant que status = 1 signifie actif
end

local function getContestEntry(player)
    local playerId = player:getID()
    local query = string.format("SELECT fishrank, score, contestrank FROM fishing_contest_entries WHERE charid = %d AND submittime > 0", playerId)
    local result = sql:query(query)
    return #result > 0 and result[1] or nil
end

local function getFishingSkillBonus(player)
    local bonus = 0
    if player:hasItem(13759) then
        bonus = bonus + 40
    end
    local contestEntry = getContestEntry(player)
    if contestEntry and isContestActive() then
        bonus = bonus + (contestEntry.fishrank * 2) -- Bonus basé sur le rang de pêche, à ajuster
    end
    return bonus
end

local function getRodBonus(player, rodName)
    local query = string.format("SELECT fish_attack, lgd_bonus_attack, fish_recovery, fish_time, lgd_bonus_time, sm_delay_bonus, sm_move_bonus, lg_delay_bonus, lg_move_bonus, min_rank FROM fishing_rod WHERE name = '%s'", rodName)
    local result = sql:query(query)
    if #result == 0 then return 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 end
    local row = result[1]
    return tonumber(row.fish_attack) or 0, tonumber(row.lgd_bonus_attack) or 0, tonumber(row.fish_recovery) or 0, 
           tonumber(row.fish_time) or 0, tonumber(row.lgd_bonus_time) or 0, tonumber(row.sm_delay_bonus) or 0, 
           tonumber(row.sm_move_bonus) or 0, tonumber(row.lg_delay_bonus) or 0, tonumber(row.lg_move_bonus) or 0, 
           tonumber(row.min_rank) or 0
end

local function getFishOrMobInZone(zoneName, baitName, rodName, player)
    local zoneIdQuery = string.format("SELECT zone_id FROM fishing_zone WHERE zone_name = '%s'", zoneName:lower())
    local zoneResult = sql:query(zoneIdQuery)
    if #zoneResult == 0 then
        player:messageBasic(xi.msg.basic.FISHING_NOTHING_CAUGHT, 0, 0, 0, "")
        return nil
    end
    local zoneId = zoneResult[1].zone_id

    local areaIdQuery = string.format("SELECT areaid FROM fishing_area WHERE zoneid = %d AND name = (SELECT name FROM fishing_area WHERE zoneid = %d LIMIT 1)", zoneId, zoneId)
    local areaResult = sql:query(areaIdQuery)
    if #areaResult == 0 then return nil end
    local areaId = areaResult[1].areaid

    local fishingSkill = player:getSkillLevel(xi.skill.FISHING) + getFishingSkillBonus(player)
    local _, _, _, _, _, _, _, _, _, minRank = getRodBonus(player, rodName)
    if fishingSkill < minRank then
        player:messageBasic(xi.msg.basic.FISHING_ROD_RANK_TOO_LOW, rodName)
        return nil
    end

    -- Tentative de pêcher un poisson standard
    local fishQuery = string.format("SELECT f.name AS fish_name FROM fishing_fish f JOIN fishing_group g ON f.fishid = g.fishid JOIN fishing_catch c ON g.groupid = c.groupid JOIN fishing_bait_affinity ba ON f.fishid = ba.fishid JOIN fishing_bait b ON ba.baitid = b.baitid JOIN fishing_rod r ON g.rarity > 0 AND r.rodid = (SELECT rodid FROM fishing_rod WHERE name = '%s') WHERE c.zoneid = %d AND c.areaid = %d AND b.name = '%s' AND r.size_type = f.size_type AND ba.power > 0 AND f.disabled = 0 ORDER BY RAND() * (ba.power * g.rarity) LIMIT 1", rodName, zoneId, areaId, baitName)
    local fishResult = sql:query(fishQuery)

    if #fishResult > 0 then
        return fishResult[1].fish_name
    end

    -- Tentative de pêcher un monstre (chance faible)
    if math.random() < 0.05 then -- Chance de 5% de pêcher un monstre, à ajuster
        local mobQuery = string.format("SELECT name AS mob_name FROM fishing_mob m WHERE m.zoneid = %d AND m.areaid = %d AND m.disabled = 0 AND (m.required_baitid = 0 OR m.required_baitid = (SELECT baitid FROM fishing_bait WHERE name = '%s') OR m.alternative_baitid = (SELECT baitid FROM fishing_bait WHERE name = '%s')) AND m.size_type <= (SELECT size_type FROM fishing_rod WHERE name = '%s') LIMIT 1", zoneId, areaId, baitName, baitName, rodName)
        local mobResult = sql:query(mobQuery)
        if #mobResult > 0 then
            return "MOB:" .. mobResult[1].mob_name -- Préfixe pour identifier un monstre
        end
    end

    player:messageBasic(xi.msg.basic.FISHING_NOTHING_CAUGHT, 0, 0, 0, "")
    return nil
end

local function checkRankProgress(player, fishingSkill)
    local playerId = player:getID()
    local query = string.format("SELECT skill_level AS current_rank FROM char_skills WHERE charid = %d AND skillid = %d", playerId, xi.skill.FISHING)
    local result = sql:query(query)
    local currentRank = result[1] and tonumber(result[1].current_rank) or xi.craftRank.NOVICE

    local rankQuery = "SELECT skill_level AS level_req, rank_value AS rank, test_item FROM fishing_ranks ORDER BY skill_level"
    local rankResult = sql:query(rankQuery)
    local rankTests = {}
    for _, row in ipairs(rankResult) do
        rankTests[tonumber(row.level_req)] = {
            rank = tonumber(row.rank),
            item = tonumber(row.test_item)
        }
    end

    for levelReq, info in pairs(rankTests) do
        if fishingSkill >= levelReq and currentRank < info.rank then
            local hasItemQuery = string.format("SELECT COUNT(*) as count FROM char_inventory WHERE charid = %d AND itemid = %d", playerId, info.item)
            local itemResult = sql:query(hasItemQuery)
            if itemResult[1].count > 0 then
                local updateQuery = string.format("UPDATE char_skills SET skill_level = %d WHERE charid = %d AND skillid = %d", info.rank, playerId, xi.skill.FISHING)
                sql:query(updateQuery)
                player:removeItem(info.item)
                player:messageBasic(xi.msg.basic.ITEM_TURNED_IN, info.item)
                player:messageBasic(xi.msg.basic.FISHING_RANK_UP)
                local updateContestQuery = string.format("UPDATE fishing_contest_entries SET fishrank = %d WHERE charid = %d", info.rank, playerId)
                sql:query(updateContestQuery)
            else
                player:messageBasic(xi.msg.basic.FISHING_TEST_REQUIRED, info.item)
            end
            break
        end
    end
end

local function handleSkillGain(player, fishName, zoneName, success)
    local fishingSkill = player:getSkillLevel(xi.skill.FISHING) + getFishingSkillBonus(player)
    local isMob = string.sub(fishName, 1, 4) == "MOB:"
    local name = isMob and string.sub(fishName, 5) or fishName
    local query = isMob and string.format("SELECT level AS skill FROM fishing_mob WHERE name = '%s'", name:lower()) or string.format("SELECT skill_level AS skill FROM fishing_fish WHERE name = '%s'", name:lower())
    local result = sql:query(query)
    local requiredSkill = result[1] and tonumber(result[1].skill) or 0

    local skillDiff = requiredSkill - fishingSkill
    local baseChance = 0.15
    if skillDiff > 0 then
        baseChance = baseChance + (skillDiff * 0.05)
    elseif skillDiff <= -10 then
        baseChance = 0
    end
    baseChance = success and baseChance or baseChance * 0.5
    if player:hasItem(15554) then
        baseChance = baseChance * 1.1
    end
    if isContestActive() then
        baseChance = baseChance * 1.2 -- Bonus fictif pendant un concours, à ajuster
    end

    local maxSkill = 1100
    if fishingSkill >= maxSkill then return end

    if math.random() < baseChance then
        local skillGain = 1
        player:setSkillLevel(xi.skill.FISHING, player:getSkillLevel(xi.skill.FISHING) + skillGain)
        player:messageBasic(xi.msg.basic.SKILL_UP, xi.skill.FISHING, fishingSkill + skillGain)
        checkRankProgress(player, fishingSkill + skillGain)
    end
end

local function checkFishingInput(player, fishName, zoneName, rodName)
    local isMob = string.sub(fishName, 1, 4) == "MOB:"
    local name = isMob and string.sub(fishName, 5) or fishName
    local query = isMob and string.format("SELECT level AS skill, difficulty AS break_chance FROM fishing_mob WHERE name = '%s'", name:lower()) or string.format("SELECT skill_level AS skill, difficulty AS break_chance FROM fishing_fish WHERE name = '%s'", name:lower())
    local result = sql:query(query)
    if #result == 0 then return false end
    local variation = result[1]
    local attack, lgdAttack, recovery, time, lgdTime, smDelay, smMove, lgDelay, lgMove, _ = getRodBonus(player, rodName)
    local zoneIdQuery = string.format("SELECT difficulty FROM fishing_zone WHERE zone_id = %d", player:getZoneID())
    local zoneResult = sql:query(zoneIdQuery)
    local zoneDifficulty = #zoneResult > 0 and tonumber(zoneResult[1].difficulty) or 0
    local baseScore = math.random(30, 70) + attack + (isMob and lgdAttack or 0) - (zoneDifficulty * 2) -- Réduction basée sur la difficulté
    local skillBonus = (player:getSkillLevel(xi.skill.FISHING) + getFishingSkillBonus(player)) - tonumber(variation.skill) + recovery
    local breakChance = tonumber(variation.break_chance) or (tonumber(variation.difficulty) / 100) * (1 + zoneDifficulty / 10) -- Augmentation basée sur la difficulté
    local moonBonus = 1.0 -- À ajuster avec moon_pattern si disponible
    local weatherBonus = 1.0 -- À ajuster avec weather data si disponible
    local timeBonus = 1.0 -- À ajuster avec hour_pattern si disponible

    if isContestActive() then
        breakChance = breakChance * 0.8 -- Réduction fictif du risque de casse pendant un concours, à ajuster
    end

    if skillBonus < -15 then
        player:messageBasic(xi.msg.basic.FISHING_FEELING_TERRIBLE)
    elseif skillBonus < 0 then
        player:messageBasic(xi.msg.basic.FISHING_FEELING_BAD)
    else
        player:messageBasic(xi.msg.basic.FISHING_FEELING_GOOD)
    end

    local inputScore = 0
    local adjustedDuration = FishingCore.tensionGameDuration + time + (isMob and lgdTime or 0)
    for _ = 1, adjustedDuration do
        local input = math.random(-1, 1)
        if input ~= 0 then
            inputScore = inputScore + 10 + (isMob and smMove or 0) + (not isMob and lgMove or 0)
        end
        if math.random() < breakChance and (isMob and lgDelay or smDelay) < math.random() then -- Ajustement avec bonus de délai
            player:messageBasic(xi.msg.basic.FISHING_ROD_BROKE)
            handleSkillGain(player, fishName, zoneName, false)
            local query = string.format("SELECT breakable, broken_rodid FROM fishing_rod WHERE name = '%s'", rodName)
            local rodResult = sql:query(query)
            if #rodResult > 0 and rodResult[1].breakable == 1 then
                player:removeItemByName(rodName)
                if rodResult[1].broken_rodid then
                    player:addItem(tonumber(rodResult[1].broken_rodid))
                    player:messageBasic(xi.msg.basic.FISHING_ROD_BROKEN, rodName, tonumber(rodResult[1].broken_rodid))
                end
            end
            return false
        end
    end

    local totalScore = baseScore + inputScore + (skillBonus * 0.5)
    totalScore = totalScore * moonBonus * weatherBonus * timeBonus
    local success = totalScore >= FishingCore.requiredTensionScore
    handleSkillGain(player, fishName, zoneName, success)
    return success
end

local function resolveCatch(player, fishName, zoneName)
    local isMob = string.sub(fishName, 1, 4) == "MOB:"
    local name = isMob and string.sub(fishName, 5) or fishName
    local query = isMob and string.format("SELECT mobid AS item_id FROM fishing_mob WHERE name = '%s'", name:lower()) or string.format("SELECT item AS item_id FROM fishing_fish WHERE name = '%s'", name:lower())
    local result = sql:query(query)
    local fishId = result[1] and tonumber(result[1].item_id) or (isMob and 0 or 4481) -- 0 pour mob, 4481 pour poisson par défaut
    if fishId then
        if isMob then
            player:messageBasic(xi.msg.basic.FISHING_BITE_MONSTER_CAUGHT, name) -- Message fictif, à définir
            -- Logique pour gérer le monstre (ex. combat ou récompense spéciale)
        elseif player:addItem(fishId) then
            player:setVar("FishingFatigueCount", player:getVar("FishingFatigueCount") + 1)
            local contestEntry = getContestEntry(player)
            if isContestActive() and contestEntry then
                local newScore = contestEntry.score + 10 -- Score fictif, à ajuster
                local updateQuery = string.format("UPDATE fishing_contest_entries SET score = %d, submittime = %d WHERE charid = %d", newScore, os.time(), player:getID())
                sql:query(updateQuery)
                player:messageBasic(xi.msg.basic.FISHING_CONTEST_SUCCESS, fishId) -- Message fictif, à définir
            else
                player:messageBasic(xi.msg.basic.FISHING_SUCCESS, fishId)
            end
        else
            player:messageBasic(xi.msg.basic.FISHING_FAIL_INV_FULL)
        end
    else
        player:messageBasic(xi.msg.basic.FISHING_FAIL)
    end
end

function FishingCore.manualFish(player, baitName, rodName)
    if not checkFishingFatigue(player) then return end
    if not isNearWater(player) then
        player:messageBasic(xi.msg.basic.FISHING_NO_WATER)
        return
    end

    local zoneName = player:getZoneName()
    local fishName = getFishOrMobInZone(zoneName, baitName, rodName, player)
    if not fishName then return end

    local isMob = string.sub(fishName, 1, 4) == "MOB:"
    local name = isMob and string.sub(fishName, 5) or fishName
    local query = string.format("SELECT legendary AS is_monster, item AS is_item, size_type AS size FROM fishing_fish WHERE name = '%s'", name:lower())
    local result = sql:query(query)
    if isMob then
        player:messageBasic(xi.msg.basic.FISHING_BITE_MONSTER)
    elseif result and result[1] then
        local fish = result[1]
        if fish and fish.is_monster == 1 then
            player:messageBasic(xi.msg.basic.FISHING_BITE_MONSTER)
        elseif fish and fish.is_item == 1 then
            player:messageBasic(xi.msg.basic.FISHING_BITE_ITEM)
        elseif fish and fish.size > 0 then -- Approximation pour large
            player:messageBasic(xi.msg.basic.FISHING_BITE_LARGE)
        else
            player:messageBasic(xi.msg.basic.FISHING_BITE_SMALL)
        end
    end

    local biteDelay = math.random(FishingCore.biteDelayMin, FishingCore.biteDelayMax)
    player:timer(biteDelay * 1000, function()
        if checkFishingInput(player, fishName, zoneName, rodName) then
            resolveCatch(player, fishName, zoneName)
        else
            player:messageBasic(xi.msg.basic.FISHING_LOST_CATCH)
        end
    end)
end

function FishingCore.autoFish(player, baitName, rodName)
    while player:getHP() > 0 and checkFishingFatigue(player) do
        FishingCore.manualFish(player, baitName, rodName)
        player:timer(5000, function() end)
    end
end

return FishingCore