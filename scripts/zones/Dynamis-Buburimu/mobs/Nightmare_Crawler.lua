-----------------------------------
-- Area: Dynamis - Buburimu
--  Mob: Nightmare Crawler
-----------------------------------
mixins = { require('scripts/mixins/dynamis_dreamland') }
-----------------------------------
---@type TMobEntity
local entity = {}

entity.onMobSpawn = function(mob)
    mob:setLocalVar('dynamis_currency', 1455)
end

entity.onMobDeath = function(mob, player, optParams)
end

return entity
