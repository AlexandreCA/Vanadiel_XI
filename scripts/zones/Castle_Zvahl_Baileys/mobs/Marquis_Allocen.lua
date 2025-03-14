-----------------------------------
-- Area: Castle Zvahl Baileys (161)
--   NM: Marquis Allocen
-----------------------------------
mixins = { require('scripts/mixins/job_special') }
-----------------------------------
---@type TMobEntity
local entity = {}

local spawnPoints =
{
    { x = -44.116, y = -4.496, z = 37.549 },
    { x = -41.898, y = -4.000, z = 56.042 },
    { x = -31.121, y = -4.000, z = 50.880 },
    { x = -43.564, y = -4.000, z = 53.843 },
    { x = -41.605, y = -4.000, z = 55.350 },
    { x = -20.371, y = -4.000, z = 56.349 },
    { x = -26.795, y = -4.000, z = 40.714 },
    { x = -26.174, y = -4.000, z = 41.675 },
    { x = -25.052, y = -4.000, z = 34.312 },
    { x = -32.637, y = -4.000, z = 49.257 },
    { x = -46.856, y = -4.000, z = 37.937 },
    { x = -33.770, y = -4.000, z = 50.779 },
    { x = -29.703, y = -4.000, z = 52.586 },
    { x = -36.502, y = -4.000, z = 46.858 },
    { x = -25.545, y = -4.000, z = 48.679 },
    { x = -25.149, y = -4.000, z = 34.194 },
    { x = -44.981, y = -4.000, z = 55.805 },
    { x = -46.060, y = -4.000, z = 41.147 },
    { x = -35.931, y = -4.000, z = 55.033 },
    { x = -40.179, y = -4.000, z = 37.523 },
    { x = -34.023, y = -4.000, z = 49.767 },
    { x = -36.089, y = -4.000, z = 34.967 },
    { x = -31.021, y = -4.000, z = 44.052 },
    { x = -22.466, y = -4.000, z = 49.179 },
    { x = -24.819, y = -4.000, z = 33.248 },
    { x = -30.175, y = -4.000, z = 37.415 },
    { x = -44.069, y = -4.000, z = 46.024 },
    { x = -37.015, y = -4.000, z = 36.686 },
    { x = -42.931, y = -4.000, z = 50.644 },
    { x = -26.153, y = -4.000, z = 58.288 },
    { x = -38.545, y = -4.000, z = 57.590 },
    { x = -42.550, y = -4.000, z = 45.172 },
    { x = -39.958, y = -4.000, z = 32.519 },
    { x = -45.529, y = -4.000, z = 50.184 },
    { x = -35.975, y = -4.000, z = 49.437 },
    { x = -33.853, y = -4.000, z = 47.095 },
    { x = -32.779, y = -4.000, z = 36.492 },
    { x = -31.144, y = -4.000, z = 34.182 },
    { x = -30.943, y = -4.000, z = 56.809 },
    { x = -41.128, y = -4.000, z = 42.839 },
    { x = -25.411, y = -4.000, z = 52.437 },
    { x = -22.826, y = -4.000, z = 40.630 },
    { x = -27.296, y = -4.000, z = 38.243 },
    { x = -42.611, y = -4.000, z = 36.112 },
    { x = -24.652, y = -4.000, z = 35.945 },
    { x = -44.697, y = -4.000, z = 37.971 },
    { x = -40.524, y = -4.000, z = 35.199 },
    { x = -27.895, y = -4.000, z = 39.197 },
    { x = -25.233, y = -4.000, z = 33.510 },
    { x = -45.587, y = -4.000, z = 44.461 },
}

entity.onMobInitialize = function(mob)
    xi.mob.updateNMSpawnPoint(mob, spawnPoints)
    mob:setRespawnTime(math.random(900, 10800))
end

entity.onMobDespawn = function(mob)
    -- Set Marquis_Allocen's spawnpoint and respawn time (21-24 hours)
    xi.mob.updateNMSpawnPoint(mob, spawnPoints)
    mob:setRespawnTime(math.random(75600, 86400))
end

return entity
