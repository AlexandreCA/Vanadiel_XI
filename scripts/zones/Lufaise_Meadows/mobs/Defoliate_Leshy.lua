-----------------------------------
-- Area: Lufaise Meadows
--  Mob: Defoliate Leshy
-----------------------------------
---@type TMobEntity
local entity = {}

entity.onMobDeath = function(mob, player, optParams)
    if optParams.isKiller then
        GetMobByID(mob:getID()-1):setLocalVar('timeToGrow', GetSystemTime() + math.random(43200, 86400)) -- Colorful in 12 to 24 hours
    end
end

entity.onMobDespawn = function(mob)
    local phIndex = mob:getLocalVar('phIndex')
    mob:setLocalVar('phIndex', 0)
    DisallowRespawn(mob:getID(), true)
    DisallowRespawn(phIndex, false)
    GetMobByID(phIndex):setRespawnTime(GetMobRespawnTime(phIndex))
end

return entity
