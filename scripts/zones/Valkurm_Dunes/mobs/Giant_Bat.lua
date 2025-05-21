-----------------------------------
-- Area: Valkurm Dunes (103)
--  Mob: Giant Bat
--  PH for Golden Bat
-----------------------------------
local ID = zones[xi.zone.VALKURM_DUNES]
-----------------------------------
---@type TMobEntity
local entity = {}

local goldenBatPHTable =
{
    [ID.mob.GOLDEN_BAT - 3] = ID.mob.GOLDEN_BAT, -- -296.679 -0.510 -164.298
    [ID.mob.GOLDEN_BAT - 2] = ID.mob.GOLDEN_BAT, -- -804.502 -8.567 22.082
    [ID.mob.GOLDEN_BAT - 1] = ID.mob.GOLDEN_BAT, -- -798.674 -8.672 19.204
}

local goldenBatSpawnPoints =
{
    { x = -804.502, y = -8.567, z = 22.082 },
    { x = -798.674, y = -8.672, z = 19.204 },
    { x = -778.844, y = -7.842, z = 25.860 },
    { x = -807.523, y = -8.022, z = 23.607 },
    { x = -772.254, y = -7.567, z = 20.874 },
    { x = -787.206, y = -8.574, z = 20.903 },
    { x = -774.324, y = -7.502, z = 20.253 },
    { x = -776.624, y = -7.464, z = 24.271 },
    { x = -798.915, y = -8.117, z = 17.802 },
    { x = -779.336, y = -7.439, z = 21.866 },
    { x = -785.714, y = -8.436, z = 21.917 },
    { x = -785.475, y = -8.419, z = 20.912 },
    { x = -801.056, y = -8.000, z = 19.913 },
    { x = -775.578, y = -7.484, z = 21.065 },
    { x = -811.618, y = -8.139, z = 28.638 },
    { x = -796.484, y = -8.691, z = 19.190 },
    { x = -798.394, y = -8.000, z = 21.387 },
    { x = -806.759, y = -8.051, z = 23.825 },
    { x = -780.327, y = -7.531, z = 23.170 },
    { x = -785.197, y = -8.400, z = 22.135 },
    { x = -798.992, y = -8.000, z = 20.315 },
    { x = -805.583, y = -8.005, z = 21.835 },
}

entity.onMobDeath = function(mob, player, optParams)
end

entity.onMobDespawn = function(mob)
    local params = { }
    params.spawnPoints = goldenBatSpawnPoints
    xi.mob.phOnDespawn(mob, goldenBatPHTable, 5, 3600, params) -- 1 hour minimum
end

return entity
