-----------------------------------
-- Area: Dynamis - Jeuno
--  Mob: Vanguard Necromancer
-----------------------------------
mixins =
{
    require('scripts/mixins/dynamis_beastmen'),
    require('scripts/mixins/job_special')
}
local ID = zones[xi.zone.DYNAMIS_JEUNO]
-----------------------------------
---@type TMobEntity
local entity = {}

entity.onMobDeath = function(mob, player, optParams)
end

entity.onMobDespawn = function(mob)
    xi.mob.phOnDespawn(mob, ID.mob.MORTILOX_WARTPAWS_PH, 10, 1200) -- 10% lottery chance and 20 minute cooldown values ASSUMED same as Dynamis-Beaucedine/Xarcabard, needs final verification
end

return entity
