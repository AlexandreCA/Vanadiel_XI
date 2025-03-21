-----------------------------------
-- Area: Castle Zvahl Keep (162)
--  Mob: Demon Wizard
-- Note: PH for Baron Vapula
-----------------------------------
local ID = zones[xi.zone.CASTLE_ZVAHL_KEEP]
-----------------------------------
---@type TMobEntity
local entity = {}

local baronSpawnPoints =
{
    { x = -254.000, y = -52.125, z =  86.000 },
    { x = -227.007, y = -52.125, z =  83.768 },
    { x = -229.279, y = -52.000, z =  75.930 },
    { x = -228.059, y = -52.000, z =  69.774 },
    { x = -253.518, y = -52.000, z =  79.440 },
    { x = -240.067, y = -52.000, z =  75.632 },
    { x = -242.848, y = -52.000, z =  62.433 },
    { x = -240.727, y = -52.000, z =  67.280 },
    { x = -241.806, y = -52.000, z =  66.123 },
    { x = -228.644, y = -52.000, z =  62.147 },
    { x = -255.356, y = -52.000, z =  67.108 },
    { x = -254.100, y = -52.000, z =  66.232 },
    { x = -237.417, y = -52.000, z =  89.265 },
    { x = -252.495, y = -52.000, z =  85.816 },
    { x = -236.290, y = -52.000, z =  66.717 },
    { x = -228.938, y = -52.000, z =  93.861 },
    { x = -221.942, y = -52.000, z =  78.262 },
    { x = -252.429, y = -52.000, z =  98.547 },
    { x = -226.150, y = -52.000, z =  95.188 },
    { x = -252.835, y = -52.000, z = 100.906 },
    { x = -254.170, y = -52.000, z =  96.277 },
    { x = -221.530, y = -52.000, z =  71.259 },
    { x = -254.421, y = -52.000, z =  64.710 },
    { x = -240.291, y = -52.000, z =  73.774 },
    { x = -231.537, y = -52.000, z =  81.883 },
    { x = -243.871, y = -52.000, z =  88.098 },
    { x = -245.952, y = -52.000, z =  91.905 },
    { x = -232.526, y = -52.000, z =  66.246 },
    { x = -235.514, y = -52.000, z =  61.160 },
    { x = -238.189, y = -52.000, z =  63.115 },
    { x = -252.521, y = -52.000, z =  73.187 },
    { x = -253.101, y = -52.000, z =  86.190 },
    { x = -249.106, y = -52.000, z =  81.028 },
    { x = -247.540, y = -52.000, z =  63.103 },
    { x = -248.749, y = -52.000, z =  75.484 },
    { x = -253.834, y = -52.000, z =  91.747 },
    { x = -246.733, y = -52.000, z =  99.230 },
    { x = -220.010, y = -52.000, z =  91.830 },
    { x = -254.296, y = -52.000, z =  65.613 },
    { x = -255.404, y = -52.000, z =  87.626 },
    { x = -227.569, y = -52.000, z =  65.406 },
    { x = -256.271, y = -52.000, z =  73.904 },
    { x = -225.387, y = -52.000, z =  89.332 },
    { x = -231.726, y = -52.000, z =  81.945 },
    { x = -244.595, y = -52.000, z =  81.257 },
    { x = -222.026, y = -52.000, z =  63.642 },
    { x = -240.377, y = -52.000, z =  75.310 },
    { x = -257.016, y = -52.000, z =  81.345 },
    { x = -253.460, y = -52.000, z =  71.424 },
    { x = -232.100, y = -52.000, z =  93.063 },
}

local baronPHTable =
{
    [ID.mob.BARON_VAPULA - 3] = ID.mob.BARON_VAPULA, -- -254.000 -52.125 86.000
    [ID.mob.BARON_VAPULA - 1] = ID.mob.BARON_VAPULA, -- -227.007 -52.125 83.768
}

entity.onMobDeath = function(mob, player, optParams)
end

entity.onMobDespawn = function(mob)
    xi.mob.phOnDespawn(mob, baronPHTable, 10, 1, { spawnPoints = baronSpawnPoints }) -- No respawn
end

return entity
