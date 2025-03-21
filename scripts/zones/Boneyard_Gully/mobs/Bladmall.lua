-----------------------------------
-- Area: Boneyard Gully
--  Mob: Bladmall
--  ENM: Shell We Dance?
-----------------------------------
local ID = zones[xi.zone.BONEYARD_GULLY]
-----------------------------------
---@type TMobEntity
local entity = {}

entity.onMobSpawn = function(mob)
end

entity.onMobFight = function(mob, target)
    local hpp         = mob:getHPP()
    local battlefield = mob:getBattlefield()
    if not battlefield then
        return
    end

    local bfID        = battlefield:getArea()
    local adds        = mob:getLocalVar('adds')
    local petID       = 0

    -- Pet #1 spawn at 95% hp or less
    if hpp <= 95 and adds == 0 then
        mob:setLocalVar('adds', adds + 1)
        petID = ID.shellWeDance[bfID].BLADMALL_PET_IDS[1]
    end

    -- Pet #2 spawn at 60% hp or less
    if hpp <= 60 and mob:getLocalVar('adds') == 1 then
        mob:setLocalVar('adds', adds + 1)
        petID = ID.shellWeDance[bfID].BLADMALL_PET_IDS[2]
    end

    -- Pet #3 spawn at 40% hp or less
    if hpp <= 40 and mob:getLocalVar('adds') == 2 then
        mob:setLocalVar('adds', adds + 1)
        petID = ID.shellWeDance[bfID].BLADMALL_PET_IDS[3]
    end

    -- If we have spawned a pet
    if petID ~= 0 then
        local pet = SpawnMob(petID)

        if pet then
            battlefield:insertEntity(pet:getTargID(), false, true)
            pet:updateEnmity(target)

            local pos = mob:getPos()
            pet:setPos(pos.x, pos.y, pos.z, pos.rot)
        end
    end
end

entity.onMobDeath = function(mob, player, optParams)
    -- Adds die with parent
    if optParams.isKiller then
        local bfID = mob:getBattlefield():getArea()
        for _, petId in ipairs(ID.shellWeDance[bfID].BLADMALL_PET_IDS) do
            local pet = GetMobByID(petId)
            if pet and pet:isAlive() then
                pet:setHP(0)
            end
        end
    end
end

return entity
