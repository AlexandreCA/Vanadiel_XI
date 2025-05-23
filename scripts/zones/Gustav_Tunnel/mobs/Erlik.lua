-----------------------------------
-- Area: Gustav Tunnel
--  Mob: Erlik
-- Note: Place holder Baobhan Sith
-----------------------------------
local ID = zones[xi.zone.GUSTAV_TUNNEL]
-----------------------------------
---@type TMobEntity
local entity = {}

local baobhanSpawnPoints =
{
    { x = 171.000, y =  9.194, z =  55.000 },
    { x = 187.000, y =  9.000, z = 105.000 },
    { x = 200.520, y = 10.000, z =  74.319 },
    { x = 202.067, y = 10.000, z =  83.531 },
    { x = 205.191, y = 10.000, z =  72.405 },
    { x = 183.662, y =  9.664, z =  97.071 },
    { x = 170.282, y =  9.732, z =  56.263 },
    { x = 174.209, y = 10.195, z =  94.725 },
    { x = 191.909, y = 10.049, z =  98.090 },
    { x = 200.958, y = 10.824, z =  91.402 },
    { x = 168.150, y = 10.159, z =  72.047 },
    { x = 190.793, y = 10.845, z =  76.628 },
    { x = 200.433, y = 10.000, z =  73.738 },
    { x = 203.695, y =  9.920, z =  76.197 },
    { x = 194.531, y = 10.460, z =  99.478 },
    { x = 190.807, y = 10.198, z =  88.853 },
    { x = 192.297, y = 10.469, z =  72.780 },
    { x = 196.054, y = 10.254, z = 116.065 },
    { x = 194.329, y = 10.253, z = 104.081 },
    { x = 191.379, y =  9.943, z = 101.748 },
    { x = 187.642, y =  9.365, z = 103.497 },
    { x = 206.481, y = 10.309, z = 111.293 },
    { x = 206.923, y = 10.229, z =  75.423 },
    { x = 180.753, y =  9.766, z =  89.410 },
    { x = 188.868, y = 10.000, z =  88.047 },
    { x = 189.428, y = 10.118, z =  94.411 },
    { x = 176.818, y = 10.112, z =  90.268 },
    { x = 191.787, y = 10.216, z =  70.254 },
    { x = 191.632, y =  9.654, z =  85.882 },
    { x = 194.066, y =  9.935, z =  81.313 },
    { x = 186.541, y =  8.765, z =  99.796 },
    { x = 183.811, y =  9.983, z =  64.033 },
    { x = 205.306, y =  9.591, z = 115.950 },
    { x = 208.623, y = 10.255, z = 107.763 },
    { x = 180.881, y =  9.978, z =  57.924 },
    { x = 172.784, y =  9.959, z =  74.945 },
    { x = 188.840, y = 10.103, z =  92.825 },
    { x = 177.075, y = 10.000, z =  72.951 },
    { x = 204.566, y =  9.769, z =  89.016 },
    { x = 177.099, y = 10.000, z =  98.246 },
    { x = 200.263, y = 11.000, z =  96.558 },
    { x = 172.187, y = 10.406, z =  91.060 },
    { x = 198.963, y = 10.998, z =  98.396 },
    { x = 186.629, y = 10.603, z =  70.872 },
    { x = 188.628, y =  9.772, z =  64.603 },
    { x = 199.152, y = 11.000, z = 103.101 },
    { x = 187.133, y = 10.563, z =  81.969 },
    { x = 205.088, y = 10.000, z =  79.015 },
    { x = 170.731, y = 10.049, z =  77.613 },
    { x = 197.208, y = 10.121, z =  76.706 },
}

local baobhanPHTable =
{
    [ID.mob.BAOBHAN_SITH - 2] = ID.mob.BAOBHAN_SITH, -- 171.000 9.194 55.000
    [ID.mob.BAOBHAN_SITH - 1] = ID.mob.BAOBHAN_SITH, -- 187.000 9.000 105.000
}

entity.onMobDeath = function(mob, player, optParams)
    xi.regime.checkRegime(player, mob, 767, 2, xi.regime.type.GROUNDS)
end

entity.onMobDespawn = function(mob)
    xi.mob.phOnDespawn(mob, baobhanPHTable, 5, 14400, { spawnPoints = baobhanSpawnPoints }) -- 4 hours
end

return entity
