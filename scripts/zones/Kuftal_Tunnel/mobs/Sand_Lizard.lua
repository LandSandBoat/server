-----------------------------------
-- Area: Kuftal Tunnel
--  Mob: Sand Lizard
-- Note: Place Holder for Amemet
-----------------------------------
local ID = zones[xi.zone.KUFTAL_TUNNEL]
-----------------------------------
---@type TMobEntity
local entity = {}

local amemetSpawnPoints =
{
    { x = 123.046, y =  0.250, z =  18.642 },
    { x = 112.135, y = -0.278, z =  38.281 },
    { x = 112.008, y = -0.530, z =  50.994 },
    { x = 122.654, y = -0.491, z =   0.840 },
    { x = 123.186, y =  0.213, z = -24.716 },
    { x = 118.633, y = -0.470, z = -43.282 },
    { x = 109.000, y = -0.010, z = -48.000 },
    { x =  96.365, y = -0.269, z =  -7.619 },
    { x =  89.590, y = -0.321, z =  -9.390 },
    { x =  68.454, y = -0.417, z =  -0.413 },
    { x =  74.662, y = -0.513, z =   3.685 },
    { x =  67.998, y = -0.500, z =  12.000 },
    { x =  92.000, y = -0.396, z =  14.000 },
    { x =  99.475, y = -0.067, z =   9.035 },
    { x = 104.228, y =  0.000, z =   6.567 },
    { x = 109.032, y =  0.422, z =  -7.990 },
    { x = 122.583, y =  0.000, z =   0.622 },
    { x =  86.752, y =  0.000, z =  -0.573 },
    { x = 102.731, y =  0.491, z =  -5.173 },
    { x = 114.827, y =  0.408, z =   9.606 },
    { x =  96.311, y =  0.438, z =  -4.693 },
    { x =  97.652, y = -0.070, z =  -8.770 },
    { x =  90.926, y =  0.705, z =  -0.835 },
    { x = 109.931, y =  0.424, z =  -7.088 },
    { x = 112.120, y =  0.271, z =  15.939 },
    { x = 106.658, y =  0.000, z =   8.578 },
    { x = 102.354, y =  0.029, z =  -9.346 },
    { x = 104.305, y = -0.027, z =  13.815 },
    { x = 102.753, y =  0.892, z =  -2.631 },
    { x =  90.305, y =  0.580, z =  -2.025 },
    { x =  92.885, y =  0.268, z =  -4.161 },
    { x =  98.694, y =  0.244, z =   5.488 },
    { x = 100.363, y =  0.908, z =  -2.502 },
    { x = 110.300, y = -0.217, z = -19.833 },
    { x =  79.762, y =  0.267, z =  -7.177 },
    { x = 105.783, y = -0.092, z =  13.513 },
    { x = 115.739, y =  0.665, z =  16.603 },
    { x =  82.849, y = -0.025, z =   5.134 },
    { x = 102.541, y = -0.296, z =  14.131 },
    { x =  88.190, y = -0.036, z =  -5.870 },
    { x = 101.478, y = -0.230, z =   8.986 },
    { x = 112.781, y =  0.424, z =  13.979 },
    { x = 108.403, y =  0.100, z = -11.182 },
    { x = 115.181, y = -0.011, z = -10.044 },
    { x =  83.043, y =  0.000, z =   4.495 },
    { x =  92.363, y =  0.703, z =  -1.750 },
    { x =  76.068, y =  0.373, z =  -6.919 },
    { x =  98.145, y =  0.318, z =  -5.397 },
    { x = 120.448, y =  1.000, z =  15.336 },
    { x = 111.944, y = -0.081, z =   0.939 },
}

local amemetPHTable =
{
    [ID.mob.AMEMET - 84] = ID.mob.AMEMET, -- 74.662 -0.513 3.685
    [ID.mob.AMEMET - 83] = ID.mob.AMEMET, -- 109.000 -0.010 -48.000
    [ID.mob.AMEMET - 82] = ID.mob.AMEMET, -- 92.000 -0.396 14.000
    [ID.mob.AMEMET - 22] = ID.mob.AMEMET, -- 123.046 0.250 18.642
    [ID.mob.AMEMET - 16] = ID.mob.AMEMET, -- 112.135 -0.278 38.281
    [ID.mob.AMEMET - 15] = ID.mob.AMEMET, -- 112.008 -0.530 50.994
    [ID.mob.AMEMET - 14] = ID.mob.AMEMET, -- 67.998 -0.500 12.000
    [ID.mob.AMEMET - 13] = ID.mob.AMEMET, -- 89.590 -0.321 -9.390
    [ID.mob.AMEMET - 12] = ID.mob.AMEMET, -- 123.186 0.213 -24.716
    [ID.mob.AMEMET - 11] = ID.mob.AMEMET, -- 96.365 -0.269 -7.619
    [ID.mob.AMEMET - 8]  = ID.mob.AMEMET, -- 122.654 -0.491 0.840
    [ID.mob.AMEMET - 7]  = ID.mob.AMEMET, -- 68.454 -0.417 -0.413
    [ID.mob.AMEMET - 6]  = ID.mob.AMEMET, -- 118.633 -0.470 -43.282
}

entity.onMobDeath = function(mob, player, optParams)
    xi.regime.checkRegime(player, mob, 735, 2, xi.regime.type.GROUNDS)
end

entity.onMobDespawn = function(mob)
    local params = {}
    params.spawnPoints = amemetSpawnPoints
    xi.mob.phOnDespawn(mob, amemetPHTable, 5, 7200, params) -- 2 hours
end

return entity
