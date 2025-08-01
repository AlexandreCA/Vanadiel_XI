-----------------------------------
-- Area: Cloister of Gales
-- Mob: Garuda Prime
-- Quest: Waking the Beast
-----------------------------------
mixins = { require('scripts/mixins/job_special') }
-----------------------------------
---@type TMobEntity
local entity = {}

entity.onMobInitialize = function(mob)
end

entity.onMobSpawn = function(mob)
    xi.mix.jobSpecial.config(mob, {
        specials =
        {
            { id = 875, hpp = math.random(10, 90) },
        },
    })

    mob:setMobMod(xi.mobMod.NO_STANDBACK, 1)
    mob:setMobMod(xi.mobMod.SIGHT_RANGE, 13)
    mob:setMobMod(xi.mobMod.MAGIC_RANGE, 40)
    mob:setMod(xi.mod.UDMGPHYS, -6000)
    mob:setMod(xi.mod.UDMGRANGE, -6000)
    mob:setMod(xi.mod.UDMGMAGIC, -2000)
    mob:setMod(xi.mod.WIND_ABSORB, 100)
    -- do not need to set res rank for wind because WTB primes have own
    -- mob resistances row that sets it already
    mob:addImmunity(xi.immunity.GRAVITY)
    mob:addImmunity(xi.immunity.BIND)
    mob:addImmunity(xi.immunity.SILENCE)
    mob:addImmunity(xi.immunity.STUN)
    mob:addImmunity(xi.immunity.LIGHT_SLEEP)
    mob:addImmunity(xi.immunity.DARK_SLEEP)
    mob:addImmunity(xi.immunity.TERROR)
    mob:setMobMod(xi.mobMod.ADD_EFFECT, 1)
    -- element specific immunities
    mob:addImmunity(xi.immunity.SLOW)
end

entity.onAdditionalEffect = function(mob, target, damage)
    return xi.mob.onAddEffect(mob, target, damage, xi.mob.ae.ENAERO, { chance = 100, power = math.random(75, 125) })
end

entity.onMobWeaponSkill = function(target, mob, skill)
    -- if not all four elementals are alive then respawn one after using level 75 BP
    if skill:getID() == 874 then
        local pos = target:getPos()

        for i = 1, 4 do
            local elemental = GetMobByID(mob:getID() + i)

            if elemental and not elemental:isSpawned() then
                SpawnMob(elemental:getID()):updateEnmity(target)
                elemental:setPos(pos.x, pos.y, pos.z, pos.rot)
                break
            end
        end
    end
end

entity.onMobEngage = function(mob, target)
    mob:setLocalVar('healTimer', GetSystemTime() + math.random(30, 60))
    mob:setLocalVar('hateTimer', GetSystemTime() + math.random(10, 20))
end

entity.onMobFight = function(mob, target)
    -- every 30-60 seconds have one of the elementals heal (via absorbing T4 spell) either self or Garuda
    if mob:getLocalVar('healTimer') < GetSystemTime() then
        local avatarDamaged = mob:getHPP() < 100

        for i = 1, 4 do
            local elemental = GetMobByID(mob:getID() + i)

            if elemental and elemental:isAlive() then
                local elementalDamaged = elemental:getHPP() < 100

                -- only target either the elemental or avatar
                -- depending on if they are damaged
                local spellTarget = nil
                if elementalDamaged and avatarDamaged then
                    if math.random(1, 100) <= 50 then
                        spellTarget = mob
                    else
                        spellTarget = elemental
                    end
                elseif avatarDamaged then
                    spellTarget = mob
                elseif elementalDamaged then
                    spellTarget = elemental
                end

                if spellTarget then
                    elemental:castSpell(xi.magic.spell.AERO_IV, spellTarget)
                    mob:setLocalVar('healTimer', GetSystemTime() + math.random(30, 60))
                    break
                end
            end
        end
    end

    -- every 10-20 seconds have the elementals refocus on the avatar's battle target
    if mob:getLocalVar('hateTimer') < GetSystemTime() then
        for i = 1, 4 do
            local elemental = GetMobByID(mob:getID() + i)

            if elemental and elemental:isAlive() then
                elemental:updateEnmity(target)
                mob:setLocalVar('hateTimer', GetSystemTime() + math.random(10, 20))
            end
        end
    end
end

entity.onMobDeath = function(mob, player, optParams)
end

return entity
