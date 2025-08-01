-----------------------------------
-- Area: Bostaunieux Oubliette (167)
--  Mob: Bloodsucker NM
-- !pos -96.875 16.999 -277.037 167
-----------------------------------
local ID = zones[xi.zone.BOSTAUNIEUX_OUBLIETTE]
-----------------------------------
---@type TMobEntity
local entity = {}

entity.onMobInitialize = function(mob)
    mob:setMobMod(xi.mobMod.ADD_EFFECT, 1) -- "Has an Additional Effect of Drain on normal attacks"
    mob:setMobMod(xi.mobMod.GIL_MIN, 3000)
    mob:setMobMod(xi.mobMod.GIL_MAX, 9900)
end

entity.onAdditionalEffect = function(mob, target, damage)
    return xi.mob.onAddEffect(mob, target, damage, xi.mob.ae.HP_DRAIN)
end

entity.onMobDeath = function(mob, player, optParams)
    xi.regime.checkRegime(player, mob, 613, 1, xi.regime.type.GROUNDS)
end

entity.onMobDespawn = function(mob)
    UpdateNMSpawnPoint(ID.mob.BLOODSUCKER)
end

return entity
