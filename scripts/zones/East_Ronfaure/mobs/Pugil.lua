-----------------------------------
-- Area: East Ronfaure
--  Mob: Pugil
-- Note: PH for Swamfisk
-----------------------------------
---@type TMobEntity
local entity = {}

entity.onMobDeath = function(mob, player, optParams)
    xi.regime.checkRegime(player, mob, 64, 1, xi.regime.type.FIELDS)
end

entity.onMobDespawn = function(mob)
    xi.mob.phOnDespawn(mob, 'Swamfisk', 7, 3600) -- 1 hour minimum
end

return entity
