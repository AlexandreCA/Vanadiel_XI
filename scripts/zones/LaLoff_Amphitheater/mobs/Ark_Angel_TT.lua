-----------------------------------
-- Area: LaLoff Amphitheater
--  Mob: Ark Angel TT
-----------------------------------
mixins = { require('scripts/mixins/job_special') }
-----------------------------------
---@type TMobEntity
local entity = {}

entity.onMobInitialize = function(mob)
    mob:addImmunity(xi.immunity.SILENCE)
    mob:addImmunity(xi.immunity.PETRIFY)
    mob:addImmunity(xi.immunity.LIGHT_SLEEP)
    mob:addImmunity(xi.immunity.DARK_SLEEP)
    mob:addMod(xi.mod.UFASTCAST, 30)
    mob:setMobMod(xi.mobMod.CAN_PARRY, 3)
end

entity.onMobSpawn = function(mob)
    xi.mix.jobSpecial.config(mob, {
        between = 30,
        specials =
        {
            { id = xi.jsa.BLOOD_WEAPON },
            {
                id = xi.jsa.MANAFONT,
                endCode = function(mobArg) -- "Uses Manafont and ... Will cast Sleepga followed by Meteor."
                    mobArg:castSpell(273) -- sleepga
                    mobArg:castSpell(218) -- meteor
                end,
            },
        },
    })
end

entity.onMobEngage = function(mob, target)
    local mobid = mob:getID()

    for member = mobid-5, mobid + 2 do
        local m = GetMobByID(member)
        if m and m:getCurrentAction() == xi.act.ROAMING then
            m:updateEnmity(target)
        end
    end
end

entity.onMobFight = function(mob, target)
    if
        mob:hasStatusEffect(xi.effect.BLOOD_WEAPON) and
        bit.band(mob:getBehavior(), xi.behavior.STANDBACK) > 0
    then
        mob:setBehavior(bit.band(mob:getBehavior(), bit.bnot(xi.behavior.STANDBACK)))
        mob:setMobMod(xi.mobMod.TELEPORT_TYPE, 0)
        mob:setMobMod(xi.mobMod.SPAWN_LEASH, 0)
        mob:setSpellList(0)
    end

    if
        not mob:hasStatusEffect(xi.effect.BLOOD_WEAPON) and
        bit.band(mob:getBehavior(), xi.behavior.STANDBACK) == 0
    then
        mob:setBehavior(bit.bor(mob:getBehavior(), xi.behavior.STANDBACK))
        mob:setMobMod(xi.mobMod.TELEPORT_TYPE, 1)
        mob:setMobMod(xi.mobMod.SPAWN_LEASH, 22)
        mob:setSpellList(39)
    end
end

return entity
