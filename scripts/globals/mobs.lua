-----------------------------------
-- Global version of onMobDeath
-----------------------------------
require('scripts/globals/missions')
require('scripts/globals/quests')
require('scripts/globals/magic')
require('scripts/globals/utils')
-----------------------------------
xi = xi or {}
xi.mob = xi.mob or {}

-- onMobDeathEx is called from the core
xi.mob.onMobDeathEx = function(mob, player, isKiller, isWeaponSkillKill)
end

-----------------------------------
-- placeholder / lottery NMs
-----------------------------------

-- is a lottery NM already spawned or primed to pop?
local function lotteryPrimed(phList)
    local nm

    for k, v in pairs(phList) do
        nm = GetMobByID(v)
        if nm ~= nil and (nm:isSpawned() or nm:getRespawnTime() ~= 0) then
            return true
        end
    end

    return false
end

local getMobLuaPathObject = function(mob)
    if not mob then
        return nil
    end

    return xi.zones[mob:getZoneName()].mobs[mob:getName()]
end

-- This function is used to replace UpdateNMSpawnPoints() inside the Zone.lua files and the NM despawn scripts
-- - mobParam can either be a mobid or a mob entity object
-- it either accepts a table of spawn points to randomize, or looks to the mob's cached lua object for a spawnPoints entry
---@param mobParam number|CBaseEntity?
---@param spawnPointsOverride table?
xi.mob.updateNMSpawnPoint = function(mobParam, spawnPointsOverride)
    local origMobParam = mobParam
    -- sometimes we call from Zone.lua files and only have the mob id
    if type(mobParam) == 'number' then
        mobParam = GetMobByID(mobParam)
    end

    if mobParam == nil then
        print('[updateNMSpawnPoint] Invalid mob parameter:')
        print(origMobParam)

        return
    end

    -- if no spawnPoints table was sent, extract from mob lua object
    local spawnPoints = spawnPointsOverride
    if spawnPoints == nil then
        local mobObject = getMobLuaPathObject(mobParam)
        if mobObject and mobObject.spawnPoints then
            spawnPoints = mobObject.spawnPoints
        end
    end

    -- Special check for NMs with the same name but multiple IDs
    if spawnPoints and spawnPoints[mobParam:getID()] then
        spawnPoints = spawnPoints[mobParam:getID()]
    end

    if
        spawnPoints ~= nil and
        type(spawnPoints) == 'table' and
        #spawnPoints > 0
    then
        local chosenSpawn    = utils.randomEntry(spawnPoints)
        local randomRotation = math.random(0, 255) -- rotation does not matter

        -- Updates the mob's spawn point
        mobParam:setSpawn(chosenSpawn.x, chosenSpawn.y, chosenSpawn.z, randomRotation)
    else
        -- TODO This needs to stay here until all NMs have been updated to use entity.spawnPoints and the nm_spawn_points sql table is gone
        if not UpdateNMSpawnPoint(mobParam:getID()) then
            fmt('No spawn points defined for mob {} ({}) in spawnPoints.', mobParam:getName(), mobParam:getID())
        end
    end
end

-- potential lottery placeholder was killed
---@param ph CBaseEntity
---@param phNmId integer
---@param chance integer
---@param cooldown integer
---@param params table?
xi.mob.phOnDespawn = function(ph, phNmId, chance, cooldown, params)
    params = params or {}
    --[[
        params.immediate          = true    pop NM without waiting for next PH pop time
        params.dayOnly            = true    spawn NM only at day time
        params.nightOnly          = true    spawn NM only at night time
        params.noPosUpdate        = true    do not run UpdateNMSpawnPoint()
        params.spawnPoints        = { {x = , y = , z = } } table of spawn points to choose from, overrides NM's lua-defined table
        params.doNotEnablePhSpawn = true    Don't enable ph respawns after NM is killed (for chained ph systems like steelfleece)
    ]]

    local phId = ph:getID()
    local nmId = nil
    local nm = nil
    local phList = nil
    local mobEntityObj = getMobLuaPathObject(GetMobByID(phNmId))
    if mobEntityObj then
        phList = mobEntityObj.phList
        nmId   = phList and phList[phId]
        nm     = nmId and GetMobByID(nmId)
    end

    -- This was not a PH for the NM
    if
        type(nmId) ~= 'number' or
        nm == nil or
        phList == nil
    then
        return false
    end

    -- ensure certain boolean params exist
    local paramKeys =
    {
        'immediate',
        'dayOnly',
        'nightOnly',
        'noPosUpdate',
        'doNotEnablePhSpawn',
    }

    for _, pKey in ipairs(paramKeys) do
        if type(params[pKey]) ~= 'boolean' then
            params[pKey] = false
        end
    end

    if xi.settings.main.NM_LOTTERY_CHANCE then
        chance = xi.settings.main.NM_LOTTERY_CHANCE >= 0 and (chance * xi.settings.main.NM_LOTTERY_CHANCE) or 100
    end

    if xi.settings.main.NM_LOTTERY_COOLDOWN then
        cooldown = xi.settings.main.NM_LOTTERY_COOLDOWN >= 0 and (cooldown * xi.settings.main.NM_LOTTERY_COOLDOWN) or cooldown
    end

    local pop = nm:getLocalVar('pop')

    chance = math.ceil(chance * 10) -- chance / 1000.

    if
        GetSystemTime() <= pop or
        lotteryPrimed(phList) or
        math.random(1, 1000) > chance
    then
        return false
    end

    local nextRepopTime = VanadielTime() + GetMobRespawnTime(phId)
    local nextRepopHour = math.floor((nextRepopTime % xi.vanaTime.DAY) / xi.vanaTime.HOUR)
    -- If the NM is day only and spawn would happen during the night, bail out
    if
        params.dayOnly and
        nextRepopHour < 4 and
        nextRepopHour >= 20
    then
        return false
    -- If the NM is night only and spawn would happen during the day, bail out
    elseif
        params.nightOnly and
        nextRepopHour >= 4 and
        nextRepopHour < 20
    then
        return false
    end

    -- on PH death, replace PH repop with NM repop
    DisallowRespawn(phId, true)
    DisallowRespawn(nmId, false)

    -- Update mob's spawn position, if available
    if not params.noPosUpdate then
        xi.mob.updateNMSpawnPoint(nm, params.spawnPoints or nil)
    end

    -- if params.immediate is true, spawn the nm params.immediately (1ms) else use placeholder's timer
    nm:setRespawnTime(params.immediate and 1 or GetMobRespawnTime(phId))

    nm:addListener('DESPAWN', 'DESPAWN_' .. nmId, function(m)
        -- on NM death, replace NM repop with PH repop
        DisallowRespawn(nmId, true)
        if not params.doNotEnablePhSpawn then
            DisallowRespawn(phId, false)
            GetMobByID(phId):setRespawnTime(GetMobRespawnTime(phId))
        end

        if m:getLocalVar('doNotInvokeCooldown') == 0 then
            m:setLocalVar('pop', GetSystemTime() + cooldown)
        end

        m:removeListener('DESPAWN_' .. nmId)
    end)

    return true
end

-----------------------------------
-- Mob skills
-----------------------------------
xi.mob.skills =
{
    RECOIL_DIVE = 641,
    CYTOKINESIS = 2514,
    DISSOLVE = 2550,
}

-----------------------------------
-- mob additional melee effects
-----------------------------------

xi.mob.additionalEffect =
{
    BLIND      = 0,
    CURSE      = 1,
    ENAERO     = 2,
    ENBLIZZARD = 3,
    ENDARK     = 4,
    ENFIRE     = 5,
    ENLIGHT    = 6,
    ENSTONE    = 7,
    ENTHUNDER  = 8,
    ENWATER    = 9,
    EVA_DOWN   = 10,
    HP_DRAIN   = 11,
    MP_DRAIN   = 12,
    PARALYZE   = 13,
    PETRIFY    = 14,
    PLAGUE     = 15,
    POISON     = 16,
    SILENCE    = 17,
    SLOW       = 18,
    STUN       = 19,
    TERROR     = 20,
    TP_DRAIN   = 21,
    WEIGHT     = 22,
    ENAMNESIA  = 23,
    DISPEL     = 24,
}
xi.mob.ae = xi.mob.additionalEffect

local additionalEffects =
{
    [xi.mob.ae.BLIND] =
    {
        chance = 25,
        ele         = xi.element.DARK,
        sub         = xi.subEffect.BLIND,
        msg         = xi.msg.basic.ADD_EFFECT_STATUS,
        applyEffect = true,
        eff         = xi.effect.BLINDNESS,
        power       = 20,
        duration    = 30,
        minDuration = 1,
        maxDuration = 45,
    },

    [xi.mob.ae.CURSE] =
    {
        chance      = 20,
        ele         = xi.element.DARK,
        sub         = xi.subEffect.CURSE,
        msg         = xi.msg.basic.ADD_EFFECT_STATUS,
        applyEffect = true,
        eff         = xi.effect.CURSE_I,
        power       = 50,
        duration    = 300,
        minDuration = 1,
        maxDuration = 300,
    },

    [xi.mob.ae.ENAERO] =
    {
        ele                = xi.element.WIND,
        sub                = xi.subEffect.WIND_DAMAGE,
        msg                = xi.msg.basic.ADD_EFFECT_DMG,
        negMsg             = xi.msg.basic.ADD_EFFECT_HEAL,
        mod                = xi.mod.INT,
        bonusAbilityParams = { bonusmab = 0, includemab = false },
    },

    [xi.mob.ae.ENBLIZZARD] =
    {
        ele                = xi.element.ICE,
        sub                = xi.subEffect.ICE_DAMAGE,
        msg                = xi.msg.basic.ADD_EFFECT_DMG,
        negMsg             = xi.msg.basic.ADD_EFFECT_HEAL,
        mod                = xi.mod.INT,
        bonusAbilityParams = { bonusmab = 0, includemab = false },
    },

    [xi.mob.ae.ENDARK] =
    {
        ele                = xi.element.DARK,
        sub                = xi.subEffect.DARKNESS_DAMAGE,
        msg                = xi.msg.basic.ADD_EFFECT_DMG,
        negMsg             = xi.msg.basic.ADD_EFFECT_HEAL,
        mod                = xi.mod.INT,
        bonusAbilityParams = { bonusmab = 0, includemab = false },
    },

    [xi.mob.ae.ENFIRE] =
    {
        ele                = xi.element.FIRE,
        sub                = xi.subEffect.FIRE_DAMAGE,
        msg                = xi.msg.basic.ADD_EFFECT_DMG,
        negMsg             = xi.msg.basic.ADD_EFFECT_HEAL,
        mod                = xi.mod.INT,
        bonusAbilityParams = { bonusmab = 0, includemab = false },
    },

    [xi.mob.ae.ENLIGHT] =
    {
        ele                = xi.element.LIGHT,
        sub                = xi.subEffect.LIGHT_DAMAGE,
        msg                = xi.msg.basic.ADD_EFFECT_DMG,
        negMsg             = xi.msg.basic.ADD_EFFECT_HEAL,
        mod                = xi.mod.INT,
        bonusAbilityParams = { bonusmab = 0, includemab = false },
    },

    [xi.mob.ae.ENSTONE] =
    {
        ele                = xi.element.EARTH,
        sub                = xi.subEffect.EARTH_DAMAGE,
        msg                = xi.msg.basic.ADD_EFFECT_DMG,
        negMsg             = xi.msg.basic.ADD_EFFECT_HEAL,
        mod                = xi.mod.INT,
        bonusAbilityParams = { bonusmab = 0, includemab = false },
    },

    [xi.mob.ae.ENTHUNDER] =
    {
        ele                = xi.element.THUNDER,
        sub                = xi.subEffect.LIGHTNING_DAMAGE,
        msg                = xi.msg.basic.ADD_EFFECT_DMG,
        negMsg             = xi.msg.basic.ADD_EFFECT_HEAL,
        mod                = xi.mod.INT,
        bonusAbilityParams = { bonusmab = 0, includemab = false },
    },

    [xi.mob.ae.ENWATER] =
    {
        ele                = xi.element.WATER,
        sub                = xi.subEffect.WATER_DAMAGE,
        msg                = xi.msg.basic.ADD_EFFECT_DMG,
        negMsg             = xi.msg.basic.ADD_EFFECT_HEAL,
        mod                = xi.mod.INT,
        bonusAbilityParams = { bonusmab = 0, includemab = false },
    },

    [xi.mob.ae.EVA_DOWN] =
    {
        chance      = 25,
        ele         = xi.element.ICE,
        sub         = xi.subEffect.EVASION_DOWN,
        msg         = xi.msg.basic.ADD_EFFECT_STATUS,
        applyEffect = true,
        eff         = xi.effect.EVASION_DOWN,
        power       = 25,
        duration    = 30,
        minDuration = 1,
        maxDuration = 60,
    },

    [xi.mob.ae.HP_DRAIN] =
    {
        chance             = 10,
        ele                = xi.element.DARK,
        sub                = xi.subEffect.HP_DRAIN,
        msg                = xi.msg.basic.ADD_EFFECT_HP_DRAIN,
        mod                = xi.mod.INT,
        bonusAbilityParams = { bonusmab = 0, includemab = false },
        code               = function(mob, target, power)
            mob:addHP(power)
        end,
    },

    [xi.mob.ae.MP_DRAIN] =
    {
        chance             = 10,
        ele                = xi.element.DARK,
        sub                = xi.subEffect.MP_DRAIN,
        msg                = xi.msg.basic.ADD_EFFECT_MP_DRAIN,
        mod                = xi.mod.INT,
        bonusAbilityParams = { bonusmab = 0, includemab = false },
        code               = function(mob, target, power)
            local mp = math.min(power, target:getMP())
            target:delMP(mp)
            mob:addMP(mp)
        end,
    },

    [xi.mob.ae.PARALYZE] =
    {
        chance      = 25,
        ele         = xi.element.ICE,
        sub         = xi.subEffect.PARALYSIS,
        msg         = xi.msg.basic.ADD_EFFECT_STATUS,
        applyEffect = true,
        eff         = xi.effect.PARALYSIS,
        power       = 20,
        duration    = 30,
        minDuration = 1,
        maxDuration = 60,
    },

    [xi.mob.ae.PETRIFY] =
    {
        chance      = 20,
        ele         = xi.element.EARTH,
        sub         = xi.subEffect.PETRIFY,
        msg         = xi.msg.basic.ADD_EFFECT_STATUS,
        applyEffect = true,
        eff         = xi.effect.PETRIFICATION,
        power       = 1,
        duration    = 30,
        minDuration = 1,
        maxDuration = 45,
    },

    [xi.mob.ae.PLAGUE] =
    {
        chance      = 25,
        ele         = xi.element.WATER,
        sub         = xi.subEffect.PLAGUE,
        msg         = xi.msg.basic.ADD_EFFECT_STATUS,
        applyEffect = true,
        eff         = xi.effect.PLAGUE,
        power       = 1,
        duration    = 60,
        minDuration = 1,
        maxDuration = 60,
    },

    [xi.mob.ae.POISON] =
    {
        chance      = 25,
        ele         = xi.element.WATER,
        sub         = xi.subEffect.POISON,
        msg         = xi.msg.basic.ADD_EFFECT_STATUS,
        applyEffect = true,
        eff         = xi.effect.POISON,
        power       = 1,
        duration    = 30,
        minDuration = 1,
        maxDuration = 30,
        tick        = 3,
    },

    [xi.mob.ae.SILENCE] =
    {
        chance      = 25,
        ele         = xi.element.WIND,
        sub         = xi.subEffect.SILENCE,
        msg         = xi.msg.basic.ADD_EFFECT_STATUS,
        applyEffect = true,
        eff         = xi.effect.SILENCE,
        power       = 1,
        duration    = 30,
        minDuration = 1,
        maxDuration = 30,
    },

    [xi.mob.ae.ENAMNESIA] =
    {
        chance      = 25,
        ele         = xi.element.FIRE,
        sub         = xi.subEffect.AMNESIA,
        msg         = xi.msg.basic.ADD_EFFECT_STATUS,
        applyEffect = true,
        eff         = xi.effect.AMNESIA,
        power       = 1,
        duration    = 30,
        minDuration = 1,
        maxDuration = 30,
    },

    [xi.mob.ae.SLOW] =
    {
        chance      = 25,
        ele         = xi.element.EARTH,
        sub         = xi.subEffect.DEFENSE_DOWN,
        msg         = xi.msg.basic.ADD_EFFECT_STATUS,
        applyEffect = true,
        eff         = xi.effect.SLOW,
        power       = 1000,
        duration    = 30,
        minDuration = 1,
        maxDuration = 45,
    },

    [xi.mob.ae.STUN] =
    {
        chance      = 20,
        ele         = xi.element.THUNDER,
        sub         = xi.subEffect.STUN,
        msg         = xi.msg.basic.ADD_EFFECT_STATUS,
        applyEffect = true,
        eff         = xi.effect.STUN,
        duration    = 5,
    },

    [xi.mob.ae.TERROR] =
    {
        chance = 20,
        sub         = xi.subEffect.PARALYSIS,
        msg         = xi.msg.basic.ADD_EFFECT_STATUS,
        applyEffect = true,
        eff         = xi.effect.TERROR,
        duration    = 5,
        code        = function(mob, target, power)
            mob:resetEnmity(target)
        end,
    },

    [xi.mob.ae.TP_DRAIN] =
    {
        chance             = 25,
        ele                = xi.element.DARK,
        sub                = xi.subEffect.TP_DRAIN,
        msg                = xi.msg.basic.ADD_EFFECT_TP_DRAIN,
        mod                = xi.mod.INT,
        bonusAbilityParams = { bonusmab = 0, includemab = false },
        code               = function(mob, target, power)
            local tp = math.min(power, target:getTP())
            target:delTP(tp)
            mob:addTP(tp)
        end,
    },

    [xi.mob.ae.WEIGHT] =
    {
        chance      = 25,
        ele         = xi.element.WIND,
        sub         = xi.subEffect.BLIND, -- TODO
        msg         = xi.msg.basic.ADD_EFFECT_STATUS,
        applyEffect = true,
        eff         = xi.effect.WEIGHT,
        power       = 1,
        duration    = 30,
        minDuration = 1,
        maxDuration = 45,
    },

    [xi.mob.ae.DISPEL] =
    {
        chance      = 25,
        ele         = xi.element.DARK,
        sub         = xi.subEffect.DISPEL,
        msg         = xi.msg.basic.ADD_EFFECT_DISPEL,
        applyEffect = false,
        power       = 1,
    },
}

--[[
    Helper function for xi.mob.onAddEffect that applies a status effect.
--]]
local addEffectStatus = function(mob, target, ae, params)
    local resist = 1

    if ae.ele then
        resist = applyResistanceAddEffect(mob, target, ae.ele, ae.eff)
    end

    if resist > 0.5 and not target:hasStatusEffect(ae.eff) then
        local power    = params.power or ae.power or 0
        local tick     = ae.tick or 0
        local duration = params.duration or ae.duration

        duration = utils.clamp(duration, ae.minDuration, ae.maxDuration) * resist

        target:addStatusEffect(ae.eff, power, tick, duration)

        if params.code then
            params.code(mob, target, power)
        elseif ae.code then
            ae.code(mob, target, power)
        end

        return ae.sub, ae.msg, ae.eff
    end

    return 0, 0, 0
end

--[[
    Helper function for xi.mob.onAddEffect that dispels an effect.
--]]
local addEffectDispel = function(target, ae)
    local dispelledEffect = target:dispelStatusEffect(xi.effectFlag.DISPELABLE)

    if dispelledEffect == xi.effect.NONE then
        return 0, 0, 0
    end

    return ae.sub, ae.msg, dispelledEffect
end

--[[
    Helper function for xi.mob.onAddEffect that applies damage.
--]]
local addEffectImmediate = function(mob, target, damage, ae, params)
    local power = 0

    if params.power then
        power = params.power
    elseif ae.mod then
        local dMod = mob:getStat(ae.mod) - target:getStat(ae.mod)

        if dMod > 20 then
            dMod = 20 + (dMod - 20) / 2
        end

        -- This is a bad assumption, but it prevents some negative damage (healing) when there otherwise shouldn't be
        -- TODO: better understand damage add effects from mobs
        if dMod < 0 then
            dMod = 0
        end

        power = dMod + target:getMainLvl() - mob:getMainLvl() + damage / 2
    end

    -- target:printToPlayer(string.format('Initial Power: %f', power)) -- DEBUG

    power = addBonusesAbility(mob, ae.ele, target, power, ae.bonusAbilityParams)
    power = power * applyResistanceAddEffect(mob, target, ae.ele, 0)
    power = power * xi.spells.damage.calculateNukeAbsorbOrNullify(target, ae.ele)

    if ae.sub ~= xi.subEffect.TP_DRAIN and ae.sub ~= xi.subEffect.MP_DRAIN then
        power = finalMagicNonSpellAdjustments(mob, target, ae.ele, power)
    end

    -- target:printToPlayer(string.format('Adjusted Power: %f', power)) -- DEBUG

    local message = ae.msg
    if power < 0 then
        if ae.negMsg then
            message = ae.negMsg
            power   = power * -1 -- outgoing action packets only support unsigned integers. The "negative message" will also handle healing automagically deep inside core somewhere.
        else
            power = 0
        end
    end

    if power ~= 0 then
        if params.code then
            params.code(mob, target, power)
        elseif ae.code then
            ae.code(mob, target, power)
        end

        return ae.sub, message, power
    end

    return 0, 0, 0
end

--[[
    mob, target, and damage are passed from core into mob script's onAdditionalEffect
    effect should be of type xi.mob.additionalEffect (see above)
    params is a table that can contain any of:
        chance: percent chance that effect procs on hit (default 20)
        power: power of effect
        duration: duration of effect, in seconds
        code: additional code that will run when effect procs, of form function(mob, target, power)
    params will override effect's default settings
--]]
xi.mob.onAddEffect = function(mob, target, damage, effect, params)
    if type(params) ~= 'table' then
        params = {}
    end

    local ae = additionalEffects[effect]

    if ae then
        local chance = params.chance or ae.chance or 100
        local dLevel = target:getMainLvl() - mob:getMainLvl()

        if dLevel > 0 then
            chance = chance - 5 * dLevel
            chance = utils.clamp(chance, 5, 95)
        end

        -- target:printToPlayer(string.format('Chance: %i', chance)) -- DEBUG

        if math.random(1, 100) <= chance then

            -- STATUS EFFECT
            if ae.applyEffect then
                return addEffectStatus(mob, target, ae, params)

            -- DISPEL
            elseif effect == xi.mob.ae.DISPEL and target then
                return addEffectDispel(target, ae)

            -- DISPEL
            elseif effect == xi.mob.ae.DISPEL and target then
                local dispelledEffect = target:dispelStatusEffect(xi.effectFlag.DISPELABLE)

                if dispelledEffect == xi.effect.NONE then
                    return 0, 0, 0
                end

                return ae.sub, ae.msg, dispelledEffect

            -- IMMEDIATE EFFECT
            else
                return addEffectImmediate(mob, target, damage, ae, params)
            end
        end
    else
        printf('invalid additional effect for mobId %i', mob:getID())
    end

    return 0, 0, 0
end

-----------------------------------
-- mob difficulty enums for checkDifficulty()
-----------------------------------

xi.mob.difficulty =
{
    TOO_WEAK             = 0,
    INCREDIBLY_EASY_PREY = 1,
    EASY_PREY            = 2,
    DECENT_CHALLENGE     = 3,
    EVEN_MATCH           = 4,
    TOUGH                = 5,
    VERY_TOUGH           = 6,
    INCREDIBLY_TOUGH     = 7,
    MAX                  = 8,
}
xi.mob.diff = xi.mob.difficulty
