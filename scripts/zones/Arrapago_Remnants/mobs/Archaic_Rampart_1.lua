-----------------------------------
-- Area: Arrapago Remnants
--  Mob: Archaic Rampart
-----------------------------------
mixins = { require('scripts/mixins/families/rampart') }
-----------------------------------
---@type TMobEntity
local entity = {}

entity.onMobSpawn = function(mob)
end

entity.onMobFight = function(mob, target)
    local instance = mob:getInstance()
    if not instance then
        return
    end

    local popTime = mob:getLocalVar('lastPetPop')
    local mobPos = mob:getPos()
    local mobPet = GetMobByID((mob:getID() + 1), instance)

    if GetSystemTime() - popTime > 15 then
        if mobPet and not mobPet:isSpawned() then
            mobPet:setSpawn(mobPos.x, mobPos.y, mobPos.z, mobPos.rot)
            mob:useMobAbility(2034)
            mob:setLocalVar('lastPetPop', GetSystemTime())
            mob:timer(2500, function(m)
                SpawnMob((m:getID() + 1), instance)
            end)
        end
    end

    if mobPet and mobPet:isSpawned() then
        mobPet:updateEnmity(target)
    end
end

entity.onMobDeath = function(mob, player, optParams)
end

entity.onMobDespawn = function(mob)
end

return entity
