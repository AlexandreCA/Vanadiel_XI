-----------------------------------
-- Area: Dynamis - Beaucedine
--  Mob: Maa Zaua the Wyrmkeeper
-----------------------------------
mixins =
{
    require('scripts/mixins/dynamis_beastmen'),
    require('scripts/mixins/job_special'),
    require('scripts/mixins/remove_doom')
}
-----------------------------------
---@type TMobEntity
local entity = {}

entity.onMobDeath = function(mob, player, optParams)
end

return entity
