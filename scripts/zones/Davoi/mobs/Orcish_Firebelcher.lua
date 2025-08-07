-----------------------------------
-- Area: Davoi
--  Mob: Orcish Firebelcher
-- Note: PH for Poisonhand Gnadgad
-----------------------------------
---@type TMobEntity
local entity = {}

entity.onMobDeath = function(mob, player, optParams)
end

entity.onMobDespawn = function(mob)
    xi.mob.phOnDespawn(mob, 'Poisonhand_Gnadgad', 10, 3600) -- 1 hour
end

return entity
