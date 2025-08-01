-----------------------------------
-- Area: Stellar Fulcrum
--  Mob: Kam'lanaut
-- Zilart Mission 8 BCNM Fight
-----------------------------------
---@type TMobEntity
local entity = {}

local skillToAbsorb =
{
    [823] = xi.mod.FIRE_ABSORB,  -- fire_blade
    [824] = xi.mod.ICE_ABSORB,   -- frost_blade
    [825] = xi.mod.WIND_ABSORB,  -- wind_blade2
    [826] = xi.mod.EARTH_ABSORB, -- earth_blade
    [827] = xi.mod.LTNG_ABSORB,  -- lightning_blade
    [828] = xi.mod.WATER_ABSORB, -- water_blade
}

entity.onMobInitialize = function(mob)
    mob:addImmunity(xi.immunity.SILENCE)
    mob:addImmunity(xi.immunity.LIGHT_SLEEP)
    mob:addImmunity(xi.immunity.DARK_SLEEP)
end

entity.onMobEngage = function(mob, target)
    mob:setLocalVar('nextEnSkill', GetSystemTime() + 10)
end

entity.onMobFight = function(mob, target)
    if GetSystemTime() > mob:getLocalVar('nextEnSkill') then
        local skill = math.random(823, 828)
        mob:setLocalVar('currentTP', mob:getTP())
        mob:useMobAbility(skill)
        mob:setLocalVar('nextEnSkill', GetSystemTime() + 20)
    end
end

entity.onMobWeaponSkill = function(target, mob, skill)
    local skillId  = skill:getID()
    local absorbId = skillToAbsorb[skillId]

    if absorbId then
        -- ----------------------------------------------------------------------
        -- when using en-spell weapon skill, absorb damage of that element type
        -- ----------------------------------------------------------------------

        -- remove previous absorb mod, if set
        local previousAbsorb = mob:getLocalVar('currentAbsorb')

        if previousAbsorb > 0 then
            mob:setMod(previousAbsorb, 0)
        end

        -- add new absorb mod
        mob:setLocalVar('currentAbsorb', absorbId)
        mob:setMod(absorbId, 100)

        -- return TP
        mob:setTP(mob:getLocalVar('currentTP'))
    end
end

return entity
