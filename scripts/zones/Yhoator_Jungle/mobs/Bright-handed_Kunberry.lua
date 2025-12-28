-----------------------------------
-- Area: Yhoator Jungle
--   NM: Bright-handed Kunberry
-----------------------------------
mixins =
{
    require('scripts/mixins/families/tonberry'),
    require('scripts/mixins/job_special'),
    require('scripts/mixins/rotz_bodyguarded_nm')
}
-----------------------------------
---@type TMobEntity
local entity = {}

entity.spawnPoints =
{
    { x =  227.000, y = -0.500, z = -169.000 },
    { x =  170.303, y =  0.455, z = -186.105 },
    { x =  237.418, y = -0.013, z = -163.859 },
    { x =  178.692, y =  0.600, z = -165.667 },
    { x =  202.693, y =  0.232, z = -207.127 },
    { x =  226.649, y =  0.100, z = -213.963 },
    { x =  191.895, y =  0.304, z = -157.960 },
    { x =  204.182, y =  0.198, z = -193.331 },
    { x =  236.195, y =  0.230, z = -152.672 },
    { x =  207.933, y =  0.598, z = -173.478 },
    { x =  222.153, y =  0.535, z = -190.471 },
    { x =  210.044, y =  0.580, z = -177.279 },
    { x =  176.404, y =  0.583, z = -175.350 },
    { x =  197.570, y =  0.100, z = -191.125 },
    { x =  220.152, y =  0.373, z = -173.115 },
    { x =  213.315, y =  0.390, z = -183.627 },
    { x =  200.595, y =  0.543, z = -173.745 },
    { x =  189.502, y =  0.600, z = -168.138 },
    { x =  213.277, y =  0.382, z = -213.023 },
    { x =  174.920, y =  0.560, z = -155.508 },
    { x =  171.491, y =  0.300, z = -170.484 },
    { x =  237.205, y =  0.000, z = -156.992 },
    { x =  212.337, y =  0.569, z = -132.387 },
    { x =  224.991, y =  0.100, z = -210.295 },
    { x =  228.294, y =  0.100, z = -164.819 },
    { x =  181.652, y =  0.600, z = -162.661 },
    { x =  215.317, y =  0.583, z = -206.819 },
    { x =  246.780, y =  0.265, z = -188.459 },
    { x =  206.786, y =  0.432, z = -209.796 },
    { x =  219.540, y =  0.464, z = -213.919 },
    { x =  184.936, y =  0.434, z = -135.309 },
    { x =  173.151, y =  0.100, z = -189.729 },
    { x =  215.816, y =  0.329, z = -187.190 },
    { x =  189.769, y =  0.556, z = -131.560 },
    { x =  222.947, y = -0.315, z = -214.094 },
    { x =  187.531, y =  0.511, z = -158.305 },
    { x =  197.734, y =  0.000, z = -202.007 },
    { x =  185.347, y =  0.489, z = -190.552 },
    { x =  218.084, y =  0.526, z = -213.781 },
    { x =  227.669, y =  0.100, z = -159.930 },
    { x =  204.057, y =  0.100, z = -191.613 },
    { x =  188.184, y =  0.600, z = -188.101 },
    { x =  228.658, y =  0.100, z = -152.722 },
    { x =  178.971, y =  0.338, z = -137.914 },
    { x =  228.911, y =  0.100, z = -184.393 },
    { x =  213.952, y =  0.576, z = -151.060 },
    { x =  231.206, y =  0.579, z = -148.838 },
    { x =  239.555, y =  0.583, z = -175.335 },
    { x =  195.325, y =  0.048, z = -159.431 },
    { x =  220.633, y =  0.543, z = -195.269 }
}

entity.onMobInitialize = function(mob)
    xi.mob.updateNMSpawnPoint(mob)
    mob:setRespawnTime(math.random(75600, 77400)) -- 21 to 21.5 hours
end

entity.onMobDeath = function(mob, player, optParams)
    xi.regime.checkRegime(player, mob, 133, 1, xi.regime.type.FIELDS)
end

-- all body guard functionality in the rotz_bodyguarded_nm mixin

entity.onMobSpawn = function(mob)
    -- retail captures show these mods are not dependent on region control
    mob:setMod(xi.mod.UDMGPHYS, -5000)
    mob:setMod(xi.mod.UDMGRANGE, -5000)
    mob:setMod(xi.mod.UDMGBREATH, -5000)
    mob:setMod(xi.mod.UDMGMAGIC, -5000)
end

entity.onMobDespawn = function(mob)
    xi.mob.updateNMSpawnPoint(mob)
    mob:setRespawnTime(math.random(75600, 77400)) -- 21 to 21.5 hours
end

return entity
