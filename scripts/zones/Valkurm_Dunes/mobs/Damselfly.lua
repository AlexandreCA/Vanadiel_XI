-----------------------------------
-- Area: Valkurm Dunes
--  Mob: Damselfly
-- Note: Place holder Valkurm Emperor
-----------------------------------
local ID = zones[xi.zone.VALKURM_DUNES]
-----------------------------------
---@type TMobEntity
local entity = {}

local emperorPHList =
{
    [ID.mob.VALKURM_EMPEROR - 4] = ID.mob.VALKURM_EMPEROR, -- -228.957 2.776 -101.226
}

local emperorSpawnPoints =
{
    { x = -228.957, y = 2.776,  z = -101.226 },
    { x = -264.829, y = -0.843, z = -91.306  },
    { x = -95.250,  y = -0.268, z = -49.386  },
    { x = -144.284, y = -1.103, z = 4.202    },
    { x = -270.823, y = -2.168, z = -16.349  },
    { x = -327.000, y = -1.000, z = -21.000  },
    { x = -173.748, y = 0.359,  z = -77.374  },
    { x = -143.231, y = -1.973, z = -67.419  },
    { x = -281.184, y = 0.000,  z = -41.859  },
    { x = -205.980, y = 0.227,  z = -86.736  },
    { x = -282.016, y = 0.955,  z = -60.878  },
    { x = -246.524, y = -0.916, z = -51.146  },
    { x = -228.267, y = -0.028, z = -36.761  },
    { x = -220.278, y = 1.528,  z = -92.214  },
    { x = -225.198, y = 3.304,  z = -102.791 },
    { x = -185.404, y = -1.042, z = -60.996  },
    { x = -120.077, y = -0.006, z = -78.574  },
    { x = -346.179, y = -0.286, z = -23.185  },
    { x = -338.025, y = 0.232,  z = -30.453  },
    { x = -253.393, y = 0.372,  z = -87.479  },
    { x = -205.024, y = -1.791, z = -24.880  },
    { x = -279.494, y = 0.111,  z = 7.036    },
    { x = -160.476, y = -0.069, z = -41.088  },
    { x = -328.453, y = -0.837, z = -47.501  },
    { x = -205.095, y = -0.040, z = -39.637  },
    { x = -197.814, y = 0.000,  z = -80.991  },
    { x = -252.723, y = -1.271, z = -43.100  },
    { x = -333.218, y = -1.442, z = -8.725   },
    { x = -226.117, y = -1.772, z = 11.871   },
    { x = -210.075, y = -1.062, z = -27.973  },
    { x = -265.240, y = -0.799, z = -48.374  },
    { x = -130.870, y = -0.088, z = -54.813  },
    { x = -291.648, y = 0.381,  z = -42.898  },
    { x = -283.645, y = 0.351,  z = -68.965  },
    { x = -317.890, y = -0.426, z = -5.929   },
    { x = -168.851, y = -1.917, z = -54.953  },
    { x = -132.327, y = -0.742, z = -71.357  },
    { x = -329.940, y = -0.704, z = -24.331  },
    { x = -211.036, y = -0.286, z = -55.029  },
    { x = -155.887, y = 1.180,  z = -93.927  },
    { x = -291.247, y = 0.396,  z = 5.381    },
    { x = -221.531, y = 3.786,  z = -108.07  },
    { x = -284.165, y = 0.902,  z = -58.260  },
    { x = -170.882, y = -0.857, z = -35.825  },
    { x = -257.265, y = -0.995, z = -57.143  },
    { x = -212.513, y = 3.307,  z = -105.39  },
    { x = -215.818, y = 0.651,  z = -43.917  },
    { x = -297.203, y = -1.108, z = -9.745   },
    { x = -308.615, y = 0.242,  z = -44.649  },
    { x = -264.390, y = -1.137, z = 29.689   },
}

entity.onMobDeath = function(mob, player, optParams)
    xi.regime.checkRegime(player, mob, 9, 1, xi.regime.type.FIELDS)
    xi.regime.checkRegime(player, mob, 10, 2, xi.regime.type.FIELDS)
end

entity.onMobDespawn = function(mob)
    local params = { }
    params.spawnPoints = emperorSpawnPoints
    xi.mob.phOnDespawn(mob, emperorPHList, 10, 3600, params) -- 1 hour
end

return entity
