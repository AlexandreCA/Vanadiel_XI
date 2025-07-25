-----------------------------------
-- Area: Riverne - Site A01
--  Mob: Heliodromos
-----------------------------------
local ID = zones[xi.zone.RIVERNE_SITE_A01]
-----------------------------------
---@type TMobEntity
local entity = {}

entity.onMobSpawn = function(mob)
    SetServerVariable('Heliodromos_Despawn', 0)
end

entity.onMobRoam = function(mob)
    local heliodromosDespawn = GetServerVariable('Heliodromos_Despawn')

    -- 10 minutes have passed since first heliodromos dies. despawn any remaining heliodromos.
    if heliodromosDespawn > 0 and heliodromosDespawn <= GetSystemTime() then
        SetServerVariable('Heliodromos_Despawn', 0)

        -- despawn heliodromos
        for i = ID.mob.HELIODROMOS_OFFSET, ID.mob.HELIODROMOS_OFFSET + 2 do
            if GetMobByID(i):isSpawned() then
                DespawnMob(i)
            end
        end

        -- allow placeholders to respawn
        for i = ID.mob.HELIODROMOS_OFFSET - 3, ID.mob.HELIODROMOS_OFFSET - 1 do
            local ph = GetMobByID(i)

            if ph then
                DisallowRespawn(i, false)
                ph:setRespawnTime(GetMobRespawnTime(ph:getID()))
            end
        end
    end
end

entity.onMobDeath = function(mob, player, optParams)
    -- one of the heliodromos was killed. set a 10 minute despawn timer before the others despawn
    if optParams.isKiller and GetServerVariable('Heliodromos_Despawn') == 0 then
        SetServerVariable('Heliodromos_Despawn', GetSystemTime() + 600)
    end
end

entity.onMobDespawn = function(mob)
    local allHeliodromosDead = true

    for i = ID.mob.HELIODROMOS_OFFSET, ID.mob.HELIODROMOS_OFFSET + 2 do
        if GetMobByID(i):isAlive() then
            allHeliodromosDead = false
        end
    end

    if allHeliodromosDead then
        SetServerVariable('Heliodromos_ToD', GetSystemTime() + math.random(43200, 54000)) -- 12 to 15 hours

        -- allow placeholders to respawn
        for i = ID.mob.HELIODROMOS_OFFSET - 3, ID.mob.HELIODROMOS_OFFSET - 1 do
            local ph = GetMobByID(i)

            if ph then
                DisallowRespawn(i, false)
                ph:setRespawnTime(GetMobRespawnTime(ph:getID()))
            end
        end
    end
end

return entity
