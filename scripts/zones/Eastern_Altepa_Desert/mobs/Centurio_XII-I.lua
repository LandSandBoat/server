-----------------------------------
-- Area: Eastern Altepa Desert (114)
--   NM: Centurio XII-I
-----------------------------------
mixins = { require('scripts/mixins/job_special'), require('scripts/mixins/rotz_bodyguarded_nm') }
-----------------------------------
---@type TMobEntity
local entity = {}

entity.spawnPoints =
{
    { x =  -44.353, y =  -0.433, z =  -243.704 },
    { x =  -34.786, y =   0.465, z =  -228.886 },
    { x =    3.701, y =   0.000, z =  -243.510 },
    { x =    3.955, y =  -0.003, z =  -238.892 },
    { x =   19.830, y =   0.984, z =  -283.852 },
    { x =   -3.137, y =   0.000, z =  -242.198 },
    { x =    2.468, y =   0.000, z =  -240.372 },
    { x =   -4.917, y =   0.118, z =  -244.091 },
    { x =  -32.393, y =   0.523, z =  -236.804 },
    { x =   -3.849, y =  -0.038, z =  -233.005 },
    { x =   31.210, y =   0.797, z =  -268.642 },
    { x =   33.772, y =   0.708, z =  -302.429 },
    { x =  -35.067, y =   0.829, z =  -257.064 },
    { x =   -8.500, y =   0.239, z =  -274.200 },
    { x =   35.085, y =   1.015, z =  -260.615 },
    { x =  -35.310, y =   0.131, z =  -207.555 },
    { x =   20.444, y =   0.273, z =  -289.758 },
    { x =   31.475, y =   0.970, z =  -254.359 },
    { x =   -6.812, y =   0.530, z =  -215.468 },
    { x =    1.830, y =   0.281, z =  -246.096 },
    { x =  -11.398, y =   0.425, z =  -210.318 },
    { x =  -10.445, y =   0.467, z =  -211.270 },
    { x =    2.260, y =   0.000, z =  -240.063 },
    { x =  -33.172, y =   0.750, z =  -221.703 },
    { x =    0.712, y =   0.374, z =  -246.775 },
    { x =  -13.037, y =   1.651, z =  -213.927 },
    { x =  -16.184, y =   2.127, z =  -213.409 },
    { x =  -20.944, y =   0.977, z =  -205.369 },
    { x =   31.973, y =   0.966, z =  -264.395 },
    { x =  -20.658, y =   2.186, z =  -212.733 },
    { x =    7.595, y =   0.274, z =  -245.261 },
    { x =    0.902, y =   0.000, z =  -240.269 },
    { x =   13.352, y =   0.713, z =  -246.491 },
    { x =    0.985, y =   0.167, z =  -245.271 },
    { x =  -24.857, y =   0.715, z =  -207.702 },
    { x =   32.746, y =   0.154, z =  -279.851 },
    { x =   22.765, y =   0.656, z =  -244.070 },
    { x =   31.376, y =   0.165, z =  -248.220 },
    { x =  -30.113, y =   0.058, z =  -205.591 },
    { x =  -14.730, y =   0.510, z =  -272.377 },
    { x =   11.281, y =   0.362, z =  -240.123 },
    { x =    7.972, y =   0.197, z =  -281.813 },
    { x =  -30.014, y =   0.993, z =  -217.875 },
    { x =  -34.553, y =   0.117, z =  -208.212 },
    { x =   10.634, y =   0.783, z =  -250.418 },
    { x =   -2.897, y =   0.397, z =  -247.007 },
    { x =   -4.153, y =   0.011, z =  -233.778 },
    { x =  -35.120, y =   0.242, z =  -246.607 },
    { x =    2.847, y =   1.167, z =  -250.554 },
    { x =   28.891, y =   0.369, z =  -246.506 },
}

-- all body guard functionality in the rotz_bodyguarded_nm mixin

entity.onMobSpawn = function(mob)
    -- retail captures show these mods are not dependent on region control
    mob:setMod(xi.mod.UDMGPHYS, -5000)
    mob:setMod(xi.mod.UDMGRANGE, -5000)
    mob:setMod(xi.mod.UDMGBREATH, -5000)
    mob:setMod(xi.mod.UDMGMAGIC, -5000)
end

entity.onMobDeath = function(mob, player, optParams)
end

entity.onMobDespawn = function(mob)
    -- Set Centurio XII-I's spawnpoint and respawn time (21-24 hours)
    xi.mob.updateNMSpawnPoint(mob)
    mob:setRespawnTime(math.random(75600, 86400))
end

return entity
