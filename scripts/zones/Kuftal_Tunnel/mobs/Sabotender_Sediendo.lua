-----------------------------------
-- Area: Kuftal Tunnel
--  Mob: Sabotender Sediendo
-- Note: Place Holder for Sabotender Mariachi
-----------------------------------
local ID = zones[xi.zone.KUFTAL_TUNNEL]
-----------------------------------
---@type TMobEntity
local entity = {}

local mariachiSpawnPoints =
{
    { x = -23.543, y = -0.396, z =  59.578 },
    { x = -45.000, y = -0.115, z =  39.000 },
    { x = -34.263, y = -0.512, z =  30.437 },
    { x = -38.791, y =  0.230, z =  26.579 },
    { x = -41.000, y =  0.088, z =  -3.000 },
    { x = -54.912, y =  0.347, z =  -1.681 },
    { x = -58.807, y = -0.327, z =  -8.531 },
    { x = -82.074, y = -0.450, z =  -0.738 },
    { x = -84.721, y = -0.325, z =  -2.861 },
    { x = -41.000, y = -0.488, z = -31.000 },
    { x = -33.717, y = -0.448, z = -43.478 },
    { x = -17.217, y = -0.956, z = -57.647 },
    { x = -36.626, y =  0.645, z =  22.122 },
    { x = -42.018, y =  0.797, z =  24.783 },
    { x = -46.737, y = -0.340, z =  -5.031 },
    { x = -45.168, y =  0.340, z =  24.419 },
    { x = -50.903, y =  0.000, z =  26.114 },
    { x = -44.785, y =  0.000, z = -12.403 },
    { x = -48.509, y =  0.116, z =  29.248 },
    { x = -52.063, y = -0.590, z =  18.690 },
    { x = -43.815, y =  0.628, z =  20.362 },
    { x = -68.434, y =  0.038, z = -10.282 },
    { x = -38.605, y =  1.000, z =  13.136 },
    { x = -62.178, y =  0.000, z =   8.761 },
    { x = -56.767, y = -0.026, z =  14.866 },
    { x = -53.270, y = -0.603, z =  17.775 },
    { x = -83.818, y =  0.000, z =   0.745 },
    { x = -71.861, y =  0.312, z =   8.733 },
    { x = -70.231, y =  0.000, z =  -5.691 },
    { x = -48.381, y =  0.500, z =  40.530 },
    { x = -48.005, y = -0.006, z =  22.456 },
    { x = -49.404, y =  0.026, z =  17.894 },
    { x = -39.391, y =  0.326, z =  30.587 },
    { x = -45.096, y =  0.000, z =  38.272 },
    { x = -42.088, y = -0.029, z =  -3.996 },
    { x = -54.868, y =  0.178, z =   4.089 },
    { x = -60.718, y =  0.581, z =   3.455 },
    { x = -39.019, y =  0.000, z =  33.954 },
    { x = -37.809, y =  0.851, z =  25.235 },
    { x = -47.584, y =  0.000, z =  28.471 },
    { x = -55.152, y = -0.256, z =  16.030 },
    { x = -34.971, y =  0.582, z =  21.415 },
    { x = -82.260, y =  0.000, z =  -3.803 },
    { x = -39.419, y =  0.326, z =   9.410 },
    { x = -80.201, y =  0.000, z =   4.608 },
    { x = -38.632, y =  1.000, z =  17.886 },
    { x = -48.920, y =  0.000, z =  27.265 },
    { x = -73.786, y =  0.412, z =   7.445 },
    { x = -43.570, y =  0.141, z =   8.711 },
    { x = -41.902, y =  0.645, z =  27.768 },
}

local mariachiPHTable =
{
    [ID.mob.SABOTENDER_MARIACHI - 9] = ID.mob.SABOTENDER_MARIACHI, -- -17.217 -0.956 -57.647
    [ID.mob.SABOTENDER_MARIACHI - 6] = ID.mob.SABOTENDER_MARIACHI, -- -41.000 -0.488 -31.000
    [ID.mob.SABOTENDER_MARIACHI - 5] = ID.mob.SABOTENDER_MARIACHI, -- -33.717 -0.448 -43.478
    [ID.mob.SABOTENDER_MARIACHI - 3] = ID.mob.SABOTENDER_MARIACHI, -- -41.000 0.088 -3.000
    [ID.mob.SABOTENDER_MARIACHI - 2] = ID.mob.SABOTENDER_MARIACHI, -- -54.912 0.347 -1.681
    [ID.mob.SABOTENDER_MARIACHI - 1] = ID.mob.SABOTENDER_MARIACHI, -- -58.807 -0.327 -8.531
    [ID.mob.SABOTENDER_MARIACHI + 1] = ID.mob.SABOTENDER_MARIACHI, -- -82.074 -0.450 -0.738
    [ID.mob.SABOTENDER_MARIACHI + 2] = ID.mob.SABOTENDER_MARIACHI, -- -84.721 -0.325 -2.861
    [ID.mob.SABOTENDER_MARIACHI + 3] = ID.mob.SABOTENDER_MARIACHI, -- -45.000 -0.115 39.000
    [ID.mob.SABOTENDER_MARIACHI + 4] = ID.mob.SABOTENDER_MARIACHI, -- -38.791 0.230 26.579
    [ID.mob.SABOTENDER_MARIACHI + 5] = ID.mob.SABOTENDER_MARIACHI, -- -34.263 -0.512 30.437
    [ID.mob.SABOTENDER_MARIACHI + 7] = ID.mob.SABOTENDER_MARIACHI, -- -23.543 -0.396 59.578
}

entity.onMobDeath = function(mob, player, optParams)
    xi.regime.checkRegime(player, mob, 738, 2, xi.regime.type.GROUNDS)
end

entity.onMobDespawn = function(mob)
    local params = {}
    params.spawnPoints = mariachiSpawnPoints
    xi.mob.phOnDespawn(mob, mariachiPHTable, 5, 10800, params) -- 3 hours
end

return entity
