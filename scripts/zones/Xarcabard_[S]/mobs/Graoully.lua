-----------------------------------
-- Area: Xarcabard [S]
--   NM: Graoully
-----------------------------------
local ID = zones[xi.zone.XARCABARD_S]
-----------------------------------
---@type TMobEntity
local entity = {}

entity.spawnPoints =
{
    { x =  284.000, y =  0.001, z = -253.000 }
}

entity.phList =
{
    [ID.mob.GRAOULLY - 2] = ID.mob.GRAOULLY,
}

entity.onMobInitialize = function(mob)
    mob:setMobMod(xi.mobMod.ADD_EFFECT, 1)
end

entity.onAdditionalEffect = function(mob, target, damage)
    return xi.mob.onAddEffect(mob, target, damage, xi.mob.ae.PLAGUE)
end

entity.onMobDeath = function(mob, player, optParams)
    xi.hunts.checkHunt(mob, player, 542)
end

return entity
