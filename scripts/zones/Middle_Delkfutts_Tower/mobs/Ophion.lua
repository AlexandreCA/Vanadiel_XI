-----------------------------------
-- Area: Middle Delkfutt's Tower
--   NM: Ophion
-----------------------------------
mixins = { require('scripts/mixins/job_special') }
-----------------------------------
local ID = zones[xi.zone.MIDDLE_DELKFUTTS_TOWER]
-----------------------------------
---@type TMobEntity
local entity = {}

entity.phList =
{
    [ID.mob.OPHION - 16] = ID.mob.OPHION, -- -453 -95.529 -1
    [ID.mob.OPHION - 11] = ID.mob.OPHION, -- -409.937 -95.772 48.785
    [ID.mob.OPHION - 2]  = ID.mob.OPHION, -- -384 -95.529 14
}

entity.onMobDeath = function(mob, player, optParams)
    xi.hunts.checkHunt(mob, player, 337)
end

return entity
