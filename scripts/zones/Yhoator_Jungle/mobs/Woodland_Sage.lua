-----------------------------------
-- Area: Yhoator Jungle (124)
--   NM: Woodland Sage
-----------------------------------
mixins = { require('scripts/mixins/job_special') }
-----------------------------------
---@type TMobEntity
local entity = {}

entity.spawnPoints =
{
    { x =  190.942, y =  0.345, z =  94.828 },
    { x =  219.102, y =  0.430, z =  45.071 },
    { x =  230.358, y =  0.043, z =  48.605 },
    { x =  202.027, y =  0.571, z =  65.147 },
    { x =  199.007, y =  0.459, z =  68.804 },
    { x =  212.211, y =  0.282, z =  74.201 },
    { x =  240.027, y =  0.000, z =  42.375 },
    { x =  242.065, y =  0.000, z =  38.085 },
    { x =  204.844, y =  0.333, z =  49.554 },
    { x =  217.408, y =  0.130, z =  47.070 },
    { x =  197.377, y =  0.000, z =  39.511 },
    { x =  207.544, y =  0.288, z =  44.352 },
    { x =  204.460, y =  0.032, z =  35.157 },
    { x =  204.396, y =  0.457, z =  52.528 },
    { x =  239.277, y =  0.000, z =  35.625 },
    { x =  202.185, y =  0.482, z =  51.669 },
    { x =  237.334, y =  0.159, z =  46.159 },
    { x =  211.807, y =  0.289, z =  45.599 },
    { x =  235.741, y =  0.552, z =  60.963 },
    { x =  206.051, y =  0.044, z =  73.292 },
    { x =  209.542, y =  0.025, z =  49.432 },
    { x =  204.515, y =  0.423, z =  52.235 },
    { x =  200.496, y =  0.455, z =  68.871 },
    { x =  200.374, y =  0.000, z =  82.859 },
    { x =  242.325, y =  0.000, z =  77.845 },
    { x =  232.461, y =  0.218, z =  73.944 },
    { x =  196.364, y =  0.000, z =  84.094 },
    { x =  201.000, y =  0.000, z =  38.085 },
    { x =  203.632, y =  0.600, z =  60.683 },
    { x =  223.634, y =  0.600, z =  79.241 },
    { x =  213.058, y =  0.234, z =  46.280 },
    { x =  239.913, y =  0.590, z =  55.617 },
    { x =  202.871, y =  0.600, z =  62.518 },
    { x =  248.894, y = -0.010, z =  36.174 },
    { x =  234.421, y =  0.116, z =  83.652 },
    { x =  205.247, y =  0.393, z =  61.471 },
    { x =  201.787, y =  0.600, z =  58.539 },
    { x =  208.549, y =  0.048, z =  49.520 },
    { x =  225.314, y =  0.567, z =  78.223 },
    { x =  210.971, y =  0.276, z =  34.572 },
    { x =  218.020, y =  0.600, z =  77.149 },
    { x =  232.770, y =  0.116, z =  66.418 },
    { x =  205.281, y =  0.288, z =  46.910 },
    { x =  190.863, y =  0.308, z =  88.761 },
    { x =  237.683, y =  0.380, z =  49.630 },
    { x =  206.943, y =  0.218, z =  43.324 },
    { x =  207.189, y =  0.161, z =  47.552 },
    { x =  196.674, y =  0.000, z =  79.612 },
    { x =  245.816, y =  0.000, z =  41.834 },
    { x =  239.785, y =  0.000, z =  43.552 }
}

entity.onMobInitialize = function(mob)
    xi.mob.updateNMSpawnPoint(mob)
    mob:addImmunity(xi.immunity.LIGHT_SLEEP)
    mob:addImmunity(xi.immunity.DARK_SLEEP)
    mob:addImmunity(xi.immunity.SILENCE)
    mob:addImmunity(xi.immunity.TERROR)
    mob:setMobMod(xi.mobMod.ALWAYS_AGGRO, 1)
    mob:setRespawnTime(math.random(75600, 86400)) -- 21 to 24 hours
end

entity.onMobSpawn = function(mob)
    mob:setMobMod(xi.mobMod.BASE_DAMAGE_MULTIPLIER, 150)
    mob:setMaxMP(0) -- WHM but has no MP
end

entity.onMobDeath = function(mob, player, optParams)
end

entity.onMobDespawn = function(mob)
    -- Set Woodland_Sage's spawnpoint and respawn time (21-24 hours)
    xi.mob.updateNMSpawnPoint(mob)
    mob:setRespawnTime(math.random(75600, 86400))
end

return entity
