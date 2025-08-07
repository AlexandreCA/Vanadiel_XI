-----------------------------------
-- Area: Konschtat Highlands
--   NM: Tremor Ram
-- Note: PH for Rampaging Ram
-----------------------------------
require('scripts/quests/tutorial')
-----------------------------------
---@type TMobEntity
local entity = {}

entity.onMobDeath = function(mob, player, optParams)
    xi.tutorial.onMobDeath(player)
end

entity.onMobDespawn = function(mob)
    xi.mob.phOnDespawn(mob, 'Rampaging_Ram', 10, 1200) -- 20 min
end

return entity
