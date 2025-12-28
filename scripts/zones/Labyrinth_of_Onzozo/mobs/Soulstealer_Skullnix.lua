-----------------------------------
-- Area: Labyrinth of Onzozo
--   NM: Soulstealer Skullnix
-----------------------------------
mixins = { require('scripts/mixins/job_special') }
-----------------------------------
local ID = zones[xi.zone.LABYRINTH_OF_ONZOZO]
-----------------------------------
---@type TMobEntity
local entity = {}

entity.spawnPoints =
{
    { x =  38.347, y =  5.500, z =  178.050 },
    { x =  43.103, y =  5.677, z =  181.977 },
    { x =  41.150, y =  5.026, z =  204.483 },
    { x =  24.384, y =  5.471, z =  197.938 },
    { x =  13.729, y =  4.814, z =  166.295 },
    { x =   5.096, y =  3.930, z =  166.865 },
    { x =   8.225, y =  5.551, z =  151.919 },
    { x =  20.416, y =  4.832, z =  189.654 },
    { x =  -1.666, y =  4.677, z =  164.201 },
    { x =  19.538, y =  5.778, z =  197.512 },
    { x =  42.669, y =  5.287, z =  178.122 },
    { x =  16.745, y =  5.959, z =  202.097 },
    { x =  39.434, y =  5.000, z =  157.759 },
    { x =  16.071, y =  5.323, z =  183.930 },
    { x =  33.197, y =  5.412, z =  208.225 },
    { x = -12.154, y =  5.196, z =  179.741 },
    { x =  45.141, y =  4.761, z =  165.555 },
    { x =  18.929, y =  5.062, z =  189.397 },
    { x =  22.365, y =  5.674, z =  202.914 },
    { x =  -0.308, y =  5.000, z =  156.127 },
    { x =  25.342, y =  4.490, z =  190.970 },
    { x =   3.018, y =  5.500, z =  151.834 },
    { x =  47.518, y =  5.108, z =  157.538 },
    { x =  43.496, y =  5.888, z =  181.453 },
    { x =  39.093, y =  4.761, z =  167.379 },
    { x =  51.751, y =  5.148, z =  179.754 },
    { x =  28.559, y =  5.222, z =  196.991 },
    { x =   3.115, y =  4.431, z =  167.534 },
    { x =  36.808, y =  5.000, z =  200.014 },
    { x =  31.891, y =  4.984, z =  202.098 },
    { x =  26.672, y =  6.000, z =  159.843 },
    { x =   9.982, y =  4.360, z =  177.286 },
    { x =  29.577, y =  4.091, z =  182.754 },
    { x =  38.950, y =  6.000, z =  183.656 },
    { x =  -2.016, y =  5.586, z =  181.630 },
    { x =  30.351, y =  5.480, z =  157.129 },
    { x =   5.447, y =  4.854, z =  190.600 },
    { x =   3.429, y =  4.700, z =  192.220 },
    { x =  -4.040, y =  5.870, z =  178.165 },
    { x =   5.362, y =  4.431, z =  165.531 },
    { x =  13.258, y =  5.540, z =  151.087 },
    { x =  40.123, y =  5.407, z =  190.266 },
    { x =   0.356, y =  5.000, z =  157.963 },
    { x =   2.633, y =  5.907, z =  177.665 },
    { x =  21.833, y =  5.193, z =  193.164 },
    { x =  26.012, y =  4.669, z =  192.468 },
    { x =   7.124, y =  4.581, z =  173.092 },
    { x =   2.651, y =  5.336, z =  186.460 },
    { x =  16.536, y =  5.572, z =  203.888 },
    { x =  44.463, y =  5.186, z =  151.789 }
}

entity.phList =
{
    [ID.mob.SOULSTEALER_SKULLNIX + 20] = ID.mob.SOULSTEALER_SKULLNIX, -- Goblin_Shepherd:  38.347 5.500 178.050
    [ID.mob.SOULSTEALER_SKULLNIX + 25] = ID.mob.SOULSTEALER_SKULLNIX, -- Goblin_Shepherd:  41.150 5.026 204.483
    [ID.mob.SOULSTEALER_SKULLNIX + 16] = ID.mob.SOULSTEALER_SKULLNIX, -- Goblin_Mercenary: 43.103 5.677 181.977
    [ID.mob.SOULSTEALER_SKULLNIX + 13] = ID.mob.SOULSTEALER_SKULLNIX, -- Goblin_Bandit:    5.096 3.930 166.865
}

entity.onMobDeath = function(mob, player, optParams)
    xi.hunts.checkHunt(mob, player, 298)
    xi.regime.checkRegime(player, mob, 771, 2, xi.regime.type.GROUNDS)
    xi.regime.checkRegime(player, mob, 772, 2, xi.regime.type.GROUNDS)
    xi.regime.checkRegime(player, mob, 774, 2, xi.regime.type.GROUNDS)
end

return entity
