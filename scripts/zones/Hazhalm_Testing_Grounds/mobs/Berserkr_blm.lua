-----------------------------------
-- Area: Hazhalm Testing Grounds
--   Mob: Berserkr (BLM) (Einherjar)
-- Notes: Immune to Petrify
-----------------------------------
---@type TMobEntity
local entity = {}

entity.onMobInitialize = function(mob)
    mob:addImmunity(xi.immunity.PETRIFY)
end

return entity
