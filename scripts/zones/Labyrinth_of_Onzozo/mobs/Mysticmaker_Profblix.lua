-----------------------------------
-- Area: Labyrinth of Onzozo
--   NM: Mysticmaker Profblix
-----------------------------------
mixins = { require('scripts/mixins/job_special') }
-----------------------------------
---@type TMobEntity
local entity = {}

entity.spawnPoints =
{
    { x =  124.811, y = -0.363, z = -100.604 },
    { x =  109.361, y =  0.148, z = -128.993 },
    { x =  130.993, y =  0.442, z = -111.490 },
    { x =  126.928, y =  0.211, z = -106.533 },
    { x =  122.910, y =  0.000, z = -118.897 },
    { x =  112.603, y =  0.413, z = -105.733 },
    { x =  109.077, y =  0.000, z = -111.850 },
    { x =  123.890, y = -0.536, z = -112.319 },
    { x =  117.297, y =  0.416, z = -109.273 },
    { x =  112.664, y =  0.121, z = -122.534 },
    { x =  121.128, y =  0.000, z = -111.788 },
    { x =  121.333, y =  0.000, z = -120.997 },
    { x =  126.728, y =  0.180, z = -113.917 },
    { x =  119.422, y =  1.000, z =  -99.664 },
    { x =  122.871, y = -0.043, z = -127.113 },
    { x =  132.335, y = -0.089, z = -106.863 },
    { x =  130.137, y =  0.000, z = -129.243 },
    { x =  117.412, y = -0.269, z = -113.127 },
    { x =  114.242, y = -0.046, z = -126.706 },
    { x =  124.875, y = -0.213, z = -108.697 },
    { x =  121.688, y =  0.000, z = -121.562 },
    { x =  117.877, y = -0.111, z = -111.539 },
    { x =  122.518, y = -0.086, z = -115.179 },
    { x =  128.073, y =  0.290, z = -123.622 },
    { x =  103.632, y = -0.066, z = -105.804 },
    { x =  121.592, y =  0.000, z = -125.763 },
    { x =  125.757, y =  0.346, z = -122.563 },
    { x =  116.237, y = -0.156, z = -120.866 },
    { x =  131.498, y = -0.506, z = -126.574 },
    { x =  114.886, y = -0.145, z = -125.954 },
    { x =  119.943, y =  0.000, z = -116.446 },
    { x =  105.091, y = -0.233, z = -108.453 },
    { x =  125.475, y =  0.292, z = -123.448 },
    { x =  120.996, y = -0.122, z = -113.644 },
    { x =  124.071, y = -0.365, z = -108.863 },
    { x =  104.733, y =  0.248, z = -133.460 },
    { x =  129.965, y =  0.421, z = -101.528 },
    { x =  130.587, y =  0.326, z = -116.376 },
    { x =  119.320, y =  0.000, z = -126.280 },
    { x =  111.265, y =  0.361, z = -109.438 },
    { x =  109.970, y =  0.000, z = -131.393 },
    { x =  132.726, y = -0.508, z = -133.828 },
    { x =  123.419, y =  0.835, z =  -98.878 },
    { x =  117.756, y = -0.124, z = -119.150 },
    { x =  119.018, y =  0.000, z = -125.633 },
    { x =  121.352, y = -0.069, z = -124.460 },
    { x =  126.158, y =  0.049, z =  -99.448 },
    { x =  112.918, y =  0.137, z = -123.509 },
    { x =  121.109, y =  0.000, z = -116.222 },
    { x =  111.741, y = -0.059, z = -115.428 }
}

entity.onMobInitialize = function(mob)
    xi.mob.updateNMSpawnPoint(mob)
    mob:setRespawnTime(math.random(24, 30) * 300)

    mob:addImmunity(xi.immunity.STUN)
    mob:addMod(xi.mod.SILENCE_MEVA, 80)
end

entity.onMobDeath = function(mob, player, optParams)
    xi.regime.checkRegime(player, mob, 771, 2, xi.regime.type.GROUNDS)
    xi.regime.checkRegime(player, mob, 772, 2, xi.regime.type.GROUNDS)
    xi.regime.checkRegime(player, mob, 774, 2, xi.regime.type.GROUNDS)
end

entity.onMobDespawn = function(mob)
    xi.mob.updateNMSpawnPoint(mob)
    mob:setRespawnTime(math.random(24, 30) * 300) -- 2 to 2.5 hours in 5 minute windows
end

return entity
