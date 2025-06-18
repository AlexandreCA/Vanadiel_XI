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

local function getFishInZone(zoneName, baitName, rodName, player)
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

    local query = string.format("SELECT f.fish_name FROM fishing_fish f JOIN fishing_group g ON f.groupid = g.groupid JOIN fishing_bait_affinity ba ON f.fish_id = ba.fishid JOIN fishing_bait b ON ba.baitid = b.baitid JOIN fishing_rod r ON g.rod_id = r.rod_id JOIN fishing_catch c ON g.groupid = c.groupid WHERE c.zoneid = %d AND c.areaid = %d AND b.name = '%s' AND r.rod_name = '%s' AND ba.power > 0 ORDER BY RAND() * ba.power LIMIT 1", zoneId, areaId, baitName, rodName)
    local result = sql:query(query)
    if #result == 0 then
        player:messageBasic(xi.msg.basic.FISHING_NOTHING_CAUGHT, 0, 0, 0, "")
        return nil
    end
    return result[1].fish_name
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
                -- Mettre à jour fishing_contest_entries si nécessaire
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
    local query = string.format("SELECT required_skill AS skill FROM fishing_group g JOIN fishing_fish f ON g.groupid = f.groupid WHERE f.fish_name = '%s' AND g.zoneid = (SELECT zone_id FROM fishing_zone WHERE zone_name = '%s')", fishName:lower(), zoneName:lower())
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
    local query = string.format("SELECT required_skill AS skill, break_chance, moon_bonus, weather_bonus, time_bonus FROM fishing_group g JOIN fishing_fish f ON g.groupid = f.groupid WHERE f.fish_name = '%s' AND g.zoneid = (SELECT zone_id FROM fishing_zone WHERE zone_name = '%s')", fishName:lower(), zoneName:lower())
    local result = sql:query(query)
    if #result == 0 then return false end
    local variation = result[1]
    local baseScore = math.random(30, 70)
    local skillBonus = (player:getSkillLevel(xi.skill.FISHING) + getFishingSkillBonus(player)) - tonumber(variation.skill)
    local breakChance = tonumber(variation.break_chance) or 0.1
    local moonBonus = tonumber(variation.moon_bonus[xi.moonPhase()]) or 1.0
    local weatherBonus = tonumber(variation.weather_bonus[xi.weather()]) or 1.0
    local timeBonus = tonumber(variation.time_bonus[xi.time()]) or 1.0

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

local function resolveCatch(player, fishName, zoneName)
    local query = string.format("SELECT item_id FROM fishing_fish WHERE fish_name = '%s'", fishName:lower())
    local result = sql:query(query)
    local fishId = result[1] and tonumber(result[1].item_id) or 4481
    if fishId then
        if player:addItem(fishId) then
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
    local fishName = getFishInZone(zoneName, baitName, rodName, player)
    if not fishName then return end

    local query = string.format("SELECT is_monster, is_item, size FROM fishing_fish WHERE fish_name = '%s'", fishName:lower())
    local result = sql:query(query)
    local fish = result[1]
    if fish and fish.is_monster == 1 then
        player:messageBasic(xi.msg.basic.FISHING_BITE_MONSTER)
    elseif fish and fish.is_item == 1 then
        player:messageBasic(xi.msg.basic.FISHING_BITE_ITEM)
    elseif fish and fish.size = "large" then
        player:messageBasic(xi.msg.basic.FISHING_BITE_LARGE)
    else
        player:messageBasic(xi.msg.basic.FISHING_BITE_SMALL)
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