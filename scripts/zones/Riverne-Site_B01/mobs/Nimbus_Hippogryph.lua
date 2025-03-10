-----------------------------------
-- Area: Riverne - Site B01
--  Mob: Nimbus Hippogryph
-- Note: Place holder Imdugud
-----------------------------------
local ID = zones[xi.zone.RIVERNE_SITE_B01]
-----------------------------------
---@type TMobEntity
local entity = {}

local imdugudPHTable =
{
    [ID.mob.IMDUGUD - 6] = ID.mob.IMDUGUD, -- 650.770 20.052 676.513
    [ID.mob.IMDUGUD - 5] = ID.mob.IMDUGUD, -- 643.308 20.049 652.354
    [ID.mob.IMDUGUD - 4] = ID.mob.IMDUGUD, -- 669.574 19.215 623.129
    [ID.mob.IMDUGUD - 3] = ID.mob.IMDUGUD, -- 691.504 21.296 583.884
    [ID.mob.IMDUGUD - 2] = ID.mob.IMDUGUD, -- 687.199 21.161 582.560
    [ID.mob.IMDUGUD - 1] = ID.mob.IMDUGUD, -- 666.737 20.012 652.352
}

local imdugudSpawnPoints =
{
    { x = 683.664, y = 20.956, z = 573.850 },
    { x = 677.218, y = 20.961, z = 580.758 },
    { x = 688.608, y = 21.759, z = 580.093 },
    { x = 676.838, y = 20.605, z = 587.767 },
    { x = 687.905, y = 20.817, z = 590.311 },
    { x = 702.733, y = 22.215, z = 589.615 },
    { x = 713.438, y = 21.454, z = 591.400 },
    { x = 711.063, y = 20.301, z = 600.986 },
    { x = 720.089, y = 20.002, z = 604.068 },
    { x = 712.158, y = 20.413, z = 611.097 },
    { x = 701.306, y = 20.947, z = 605.691 },
    { x = 690.960, y = 20.414, z = 599.396 },
    { x = 681.175, y = 20.000, z = 601.959 },
    { x = 671.364, y = 20.282, z = 607.727 },
    { x = 683.170, y = 20.751, z = 613.054 },
    { x = 693.978, y = 20.776, z = 616.487 },
    { x = 705.144, y = 20.767, z = 620.580 },
    { x = 714.995, y = 20.846, z = 618.203 },
    { x = 718.516, y = 20.353, z = 628.741 },
    { x = 708.530, y = 20.173, z = 635.787 },
    { x = 699.179, y = 20.808, z = 631.822 },
    { x = 692.468, y = 20.777, z = 627.513 },
    { x = 686.531, y = 20.867, z = 623.026 },
    { x = 678.202, y = 20.848, z = 619.218 },
    { x = 669.828, y = 19.936, z = 619.412 },
    { x = 671.445, y = 20.188, z = 628.691 },
    { x = 678.136, y = 20.084, z = 634.284 },
    { x = 684.952, y = 20.040, z = 640.073 },
    { x = 692.255, y = 21.138, z = 648.318 },
    { x = 693.982, y = 22.835, z = 657.701 },
    { x = 686.637, y = 21.540, z = 656.963 },
    { x = 680.646, y = 20.477, z = 651.844 },
    { x = 676.018, y = 20.232, z = 644.848 },
    { x = 671.639, y = 20.312, z = 638.307 },
    { x = 667.421, y = 20.055, z = 630.375 },
    { x = 660.726, y = 19.047, z = 625.931 },
    { x = 656.838, y = 20.625, z = 637.497 },
    { x = 657.848, y = 20.819, z = 645.714 },
    { x = 661.009, y = 20.879, z = 652.272 },
    { x = 665.231, y = 20.740, z = 659.081 },
    { x = 669.946, y = 20.706, z = 664.967 },
    { x = 674.868, y = 20.000, z = 672.169 },
    { x = 675.915, y = 20.070, z = 681.807 },
    { x = 665.780, y = 20.526, z = 677.529 },
    { x = 657.944, y = 20.810, z = 671.623 },
    { x = 649.756, y = 20.716, z = 668.265 },
    { x = 641.520, y = 20.508, z = 666.251 },
    { x = 635.831, y = 20.273, z = 674.376 },
    { x = 643.327, y = 20.000, z = 679.882 },
    { x = 653.482, y = 20.489, z = 681.112 },
}

entity.onMobDeath = function(mob, player, optParams)
end

entity.onMobDespawn = function(mob)
    local params = { }
    params.spawnPoints = imdugudSpawnPoints
    xi.mob.phOnDespawn(mob, imdugudPHTable, 10, 75600, params) -- 21 hours
end

return entity
