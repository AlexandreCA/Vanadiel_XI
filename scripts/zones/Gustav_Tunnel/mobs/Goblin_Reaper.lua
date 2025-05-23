-----------------------------------
-- Area: Gustav Tunnel
--  Mob: Goblin Reaper
-- Note: Place holder Goblinsavior Heronox
-----------------------------------
local ID = zones[xi.zone.GUSTAV_TUNNEL]
-----------------------------------
---@type TMobEntity
local entity = {}

local goblinsaviorSpawnPoints =
{
    { x = 153.000, y = -10.000, z = -53.000 },
    { x = 152.325, y = -10.702, z = -77.007 },
    { x = 165.558, y = -10.647, z = -68.537 },
    { x = 169.326, y = -10.000, z = -44.555 },
    { x = 157.188, y = -9.259,  z = -70.715 },
    { x = 154.761, y = -10.446, z = -47.422 },
    { x = 151.171, y = -9.908,  z = -50.013 },
    { x = 161.577, y = -9.144,  z = -61.127 },
    { x = 161.015, y = -10.000, z = -78.574 },
    { x = 155.372, y = -9.993,  z = -36.956 },
    { x = 151.680, y = -9.634,  z = -72.750 },
    { x = 158.467, y = -9.084,  z = -54.766 },
    { x = 151.832, y = -10.000, z = -53.492 },
    { x = 146.978, y = -9.738,  z = -65.958 },
    { x = 158.040, y = -9.692,  z = -74.356 },
    { x = 151.149, y = -9.675,  z = -38.026 },
    { x = 134.791, y = -9.963,  z = -46.873 },
    { x = 144.860, y = -10.274, z = -60.785 },
    { x = 152.819, y = -9.605,  z = -72.646 },
    { x = 153.868, y = -9.676,  z = -33.704 },
    { x = 152.982, y = -9.772,  z = -80.607 },
    { x = 144.837, y = -9.566,  z = -45.640 },
    { x = 168.261, y = -9.500,  z = -80.501 },
    { x = 158.957, y = -9.755,  z = -49.593 },
    { x = 164.298, y = -9.480,  z = -50.245 },
    { x = 166.151, y = -9.693,  z = -48.175 },
    { x = 142.446, y = -9.660,  z = -46.516 },
    { x = 149.374, y = -9.460,  z = -44.596 },
    { x = 144.677, y = -10.169, z = -54.589 },
    { x = 162.580, y = -9.308,  z = -67.366 },
    { x = 139.289, y = -9.564,  z = -45.100 },
    { x = 166.004, y = -10.026, z = -40.411 },
    { x = 153.188, y = -9.824,  z = -78.708 },
    { x = 153.092, y = -10.000, z = -58.037 },
    { x = 149.135, y = -10.016, z = -53.174 },
    { x = 155.779, y = -9.342,  z = -63.919 },
    { x = 163.768, y = -10.483, z = -74.616 },
    { x = 150.094, y = -10.542, z = -57.736 },
    { x = 150.282, y = -10.015, z = -61.679 },
    { x = 157.336, y = -10.168, z = -45.316 },
    { x = 152.774, y = -10.000, z = -57.469 },
    { x = 152.244, y = -10.000, z = -58.878 },
    { x = 158.611, y = -9.050,  z = -57.051 },
    { x = 157.224, y = -9.811,  z = -84.989 },
    { x = 141.451, y = -9.000,  z = -38.400 },
    { x = 163.903, y = -10.000, z = -79.089 },
    { x = 158.943, y = -10.000, z = -79.966 },
    { x = 162.678, y = -10.151, z = -45.637 },
    { x = 165.142, y = -10.221, z = -64.614 },
    { x = 151.647, y = -9.774,  z = -63.169 },
}

local goblinsaviorPHTable =
{
    [ID.mob.GOBLINSAVIOR_HERONOX - 4] = ID.mob.GOBLINSAVIOR_HERONOX,  -- 152.325 -10.702 -77.007
    [ID.mob.GOBLINSAVIOR_HERONOX - 5] = ID.mob.GOBLINSAVIOR_HERONOX,  -- 165.558 -10.647 -68.537
}

entity.onMobDeath = function(mob, player, optParams)
    xi.regime.checkRegime(player, mob, 764, 3, xi.regime.type.GROUNDS)
    xi.regime.checkRegime(player, mob, 765, 3, xi.regime.type.GROUNDS)
end

entity.onMobDespawn = function(mob)
    xi.mob.phOnDespawn(mob, goblinsaviorPHTable, 5, 10800, { spawnPoints = goblinsaviorSpawnPoints }) -- 3 hours
end

return entity
