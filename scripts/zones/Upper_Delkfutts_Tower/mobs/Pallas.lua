-----------------------------------
-- Area: Upper Delkfutt's Tower
--   NM: Pallas
-----------------------------------
mixins = { require('scripts/mixins/job_special') }
-----------------------------------
---@type TMobEntity
local entity = {}

entity.onMobInitialize = function(mob)
    xi.pet.setMobPet(mob, 1, 'Gigass_Bat')
    mob:setMobMod(xi.mobMod.IDLE_DESPAWN, 120)
end

entity.onMobDeath = function(mob, player, optParams)
end

return entity
