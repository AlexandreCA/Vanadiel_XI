-----------------------------------
-- Area: Castle Zvahl Keep (162)
--  Mob: Demon Knight
-- Note: PH for Count Bifrons
-----------------------------------
local ID = zones[xi.zone.CASTLE_ZVAHL_KEEP]
-----------------------------------
---@type TMobEntity
local entity = {}

local bifronsSpawnPoints =
{
    { x = -204.000, y = -52.125, z =  -95.000 },
    { x = -213.226, y = -52.000, z =  -98.821 },
    { x = -220.214, y = -52.000, z =  -73.283 },
    { x = -179.992, y = -52.000, z =  -79.350 },
    { x = -214.578, y = -52.000, z =  -67.534 },
    { x = -180.364, y = -52.000, z =  -73.292 },
    { x = -182.688, y = -52.000, z = -100.957 },
    { x = -206.571, y = -52.000, z =  -99.168 },
    { x = -182.263, y = -52.000, z =  -97.322 },
    { x = -190.647, y = -52.000, z =  -61.702 },
    { x = -180.574, y = -52.000, z =  -60.631 },
    { x = -200.031, y = -52.000, z =  -60.424 },
    { x = -198.929, y = -52.000, z =  -96.154 },
    { x = -210.093, y = -52.000, z =  -59.540 },
    { x = -216.666, y = -52.000, z =  -59.602 },
    { x = -218.459, y = -52.000, z =  -96.242 },
    { x = -201.815, y = -52.000, z =  -98.409 },
    { x = -210.456, y = -52.000, z =  -96.641 },
    { x = -216.834, y = -52.000, z =  -81.850 },
    { x = -214.040, y = -52.000, z =  -76.198 },
    { x = -194.395, y = -52.000, z =  -99.207 },
    { x = -183.054, y = -52.000, z =  -60.782 },
    { x = -199.851, y = -52.000, z =  -95.658 },
    { x = -183.743, y = -52.000, z =  -61.734 },
    { x = -196.595, y = -52.000, z =  -99.336 },
    { x = -183.392, y = -52.000, z =  -92.722 },
    { x = -197.830, y = -52.000, z =  -98.323 },
    { x = -200.582, y = -52.000, z =  -61.280 },
    { x = -184.954, y = -52.000, z =  -81.470 },
    { x = -179.144, y = -52.000, z =  -66.141 },
    { x = -181.415, y = -52.000, z =  -94.378 },
    { x = -203.801, y = -52.000, z = -100.375 },
    { x = -186.934, y = -52.000, z =  -60.934 },
    { x = -216.535, y = -52.000, z =  -97.507 },
    { x = -215.854, y = -52.000, z =  -81.977 },
    { x = -219.984, y = -52.000, z =  -83.471 },
    { x = -222.291, y = -52.000, z =  -91.837 },
    { x = -215.598, y = -52.000, z =  -61.359 },
    { x = -220.905, y = -52.000, z =  -86.554 },
    { x = -188.035, y = -52.000, z = -100.713 },
    { x = -178.573, y = -52.000, z =  -61.237 },
    { x = -204.321, y = -52.000, z =  -96.828 },
    { x = -185.959, y = -52.000, z =  -88.408 },
    { x = -221.733, y = -52.000, z =  -92.348 },
    { x = -218.304, y = -52.000, z =  -84.177 },
    { x = -181.889, y = -52.000, z =  -83.607 },
    { x = -219.799, y = -52.000, z =  -97.855 },
    { x = -217.088, y = -52.000, z =  -78.886 },
    { x = -210.366, y = -52.000, z =  -63.846 },
    { x = -183.549, y = -52.000, z = -101.836 },
}

local bifronsPHTable =
{
    [ID.mob.COUNT_BIFRONS - 1] = ID.mob.COUNT_BIFRONS, -- -204.000 -52.125 -95.000
}

entity.onMobDeath = function(mob, player, optParams)
end

entity.onMobDespawn = function(mob)
    xi.mob.phOnDespawn(mob, bifronsPHTable, 10, 1, { spawnPoints = bifronsSpawnPoints }) -- No respawn
end

return entity
