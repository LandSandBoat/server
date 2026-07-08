-----------------------------------
-- Area: Ghelsba Outpost (140)
--   NM: Thousandarm Deshglesh
-----------------------------------
mixins = { require('scripts/mixins/job_special') }
-----------------------------------
local ID = zones[xi.zone.GHELSBA_OUTPOST]
-----------------------------------
---@type TMobEntity
local entity = {}

entity.spawnPoints =
{
    { x =  123.357, y = -0.102, z =  332.706 },
    { x =   94.576, y = -1.274, z =  333.168 },
    { x =   98.658, y = -0.319, z =  328.269 },
    { x =   96.763, y = -0.047, z =  319.781 },
    { x =   85.215, y = -0.739, z =  344.257 },
    { x =   80.000, y = -0.249, z =  328.000 },
    { x =   75.988, y = -0.084, z =  382.437 },
    { x =   82.000, y = -0.500, z =  366.000 },
    { x =  125.379, y = -0.049, z =  326.802 },
    { x =  124.113, y = -0.028, z =  310.829 },
    { x =  110.745, y = -0.671, z =  312.845 },
    { x =  118.320, y =  0.000, z =  312.501 },
    { x =  118.288, y =  0.000, z =  310.505 },
    { x =  109.060, y =  0.000, z =  316.920 },
    { x =  112.475, y = -0.608, z =  328.778 },
    { x =  116.154, y =  0.000, z =  309.937 },
    { x =  119.562, y =  0.000, z =  330.658 },
    { x =  112.074, y = -0.561, z =  327.541 },
    { x =  115.556, y = -0.043, z =  312.411 },
    { x =  116.173, y =  0.000, z =  328.277 },
    { x =  129.042, y =  0.000, z =  322.714 },
    { x =  123.518, y =  0.000, z =  327.042 },
    { x =  117.781, y =  0.000, z =  329.637 },
    { x =  124.124, y =  0.000, z =  327.212 },
    { x =  109.483, y = -0.530, z =  313.458 },
    { x =  130.511, y = -0.296, z =  313.858 },
    { x =  116.516, y =  0.000, z =  327.578 },
    { x =  128.057, y =  0.000, z =  317.037 },
    { x =  123.707, y =  0.000, z =  311.888 },
    { x =  112.948, y =  0.000, z =  324.380 },
    { x =  128.745, y =  0.000, z =  321.249 },
    { x =  129.607, y =  0.000, z =  317.886 },
    { x =  128.641, y =  0.000, z =  321.854 },
    { x =  117.867, y =  0.000, z =  328.531 },
    { x =  117.011, y =  0.000, z =  312.927 },
    { x =  124.531, y =  0.000, z =  326.879 },
    { x =  101.168, y = -0.764, z =  327.470 },
    { x =  114.077, y = -0.423, z =  312.147 },
    { x =  123.726, y =  0.000, z =  309.269 },
    { x =  117.597, y =  0.000, z =  330.035 },
    { x =  128.372, y =  0.000, z =  322.469 },
    { x =  109.411, y = -0.401, z =  314.082 },
    { x =  114.460, y =  0.000, z =  319.070 },
    { x =  117.493, y =  0.000, z =  323.177 },
    { x =  128.923, y = -0.502, z =  312.689 },
    { x =  109.939, y =  0.000, z =  319.280 },
    { x =  117.194, y =  0.000, z =  329.266 },
    { x =  125.767, y = -0.122, z =  326.887 },
    { x =  128.214, y = -0.551, z =  312.489 },
    { x =  112.702, y = -0.308, z =  326.545 }
}

entity.phList =
{
    [ID.mob.THOUSANDARM_DESHGLESH - 9] = ID.mob.THOUSANDARM_DESHGLESH, -- Orcish_Stonechucker: 80.000 -0.249 328.000
    [ID.mob.THOUSANDARM_DESHGLESH - 6] = ID.mob.THOUSANDARM_DESHGLESH, -- Orcish_Stonechucker: 96.763 -0.047 319.781
    [ID.mob.THOUSANDARM_DESHGLESH - 2] = ID.mob.THOUSANDARM_DESHGLESH, -- Orcish_Stonechucker: 82.000 -0.500 366.000
    [ID.mob.THOUSANDARM_DESHGLESH - 8] = ID.mob.THOUSANDARM_DESHGLESH, -- Orcish_Neckchopper:  94.576 -1.274 333.168
    [ID.mob.THOUSANDARM_DESHGLESH - 5] = ID.mob.THOUSANDARM_DESHGLESH, -- Orcish_Neckchopper:  85.215 -0.739 344.257
    [ID.mob.THOUSANDARM_DESHGLESH - 1] = ID.mob.THOUSANDARM_DESHGLESH, -- Orcish_Neckchopper:  123.357 -0.102 332.706
    [ID.mob.THOUSANDARM_DESHGLESH - 7] = ID.mob.THOUSANDARM_DESHGLESH, -- Orcish_Grunt:        98.658 -0.319 328.269
}

entity.onMobDeath = function(mob, player, optParams)
    xi.hunts.checkHunt(mob, player, 170)
end

return entity
