-----------------------------------
-- Area: Bibiki Bay
--  Mob: Shen's Filtrate - Shen Elemental
-----------------------------------
---@type TMobEntity
local entity = {}

entity.onMobInitialize = function(mob)
    mob:setMobMod(xi.mobMod.IDLE_DESPAWN, 180)
end

entity.onMobSpawn = function(mob)
    mob:addMod(xi.mod.REGEN, 120)
    mob:addImmunity(xi.immunity.BIND)
    mob:addImmunity(xi.immunity.STUN)
    mob:addImmunity(xi.immunity.POISON)
    mob:setMobMod(xi.mobMod.SKIP_ALLEGIANCE_CHECK, 1)
end

entity.onMobDeath = function(mob, player, optParams)
    local shen = mob:getZone():queryEntitiesByName('Shen')[1]
    shen:setLocalVar('filtrateDeath', 1)
end

return entity
