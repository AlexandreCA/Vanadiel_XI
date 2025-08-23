-----------------------------------
-- Area: Lower Delkfutt's Tower
--  Mob: Giant Gatekeeper
-- Note: PH for Epialtes and Hippolytos
-----------------------------------
local ID = zones[xi.zone.LOWER_DELKFUTTS_TOWER]
-----------------------------------
---@type TMobEntity
local entity = {}
entity.onMobDeath = function(mob, player, optParams)
    xi.regime.checkRegime(player, mob, 778, 2, xi.regime.type.GROUNDS)
end

entity.onMobDespawn = function(mob)
    xi.mob.phOnDespawn(mob, ID.mob.EPIALTES, 5, 1) -- no cooldown
    xi.mob.phOnDespawn(mob, ID.mob.HIPPOLYTOS, 5, 1) -- no cooldown
end

return entity
