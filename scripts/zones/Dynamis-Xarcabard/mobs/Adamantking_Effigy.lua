-----------------------------------
-- Area: Dynamis - Xarcabard
--  Mob: Adamantking Effigy
-----------------------------------
---@type TMobEntity
local entity = {}

entity.onMobSpawn = function(mob)
    xi.dynamis.refillStatueOnSpawn(mob)
end

entity.onMobDeath = function(mob, player, optParams)
    xi.dynamis.refillStatueOnDeath(mob, player, optParams)
end

return entity
