-----------------------------------
-- Area: Korroloka Tunnel (173)
--   NM: Cargo Crab Colin
-----------------------------------
local ID = zones[xi.zone.KORROLOKA_TUNNEL]
-----------------------------------
---@type TMobEntity
local entity = {}

entity.spawnPoints =
{
    { x = -30.384, y =  1.000, z = -33.277 },
    { x = -85.000, y = -0.500, z = -37.000 },
    { x = -73.365, y =  0.131, z = -39.129 },
    { x = -64.726, y =  1.000, z = -42.103 },
    { x = -75.612, y =  0.000, z = -40.800 },
    { x = -50.126, y =  0.500, z = -37.424 },
    { x = -73.592, y =  0.067, z = -44.974 },
    { x = -49.223, y =  0.496, z = -34.762 },
    { x = -45.202, y =  0.417, z = -32.101 },
    { x = -75.757, y =  0.452, z = -32.288 },
    { x = -58.936, y =  1.250, z = -39.846 },
    { x = -73.800, y =  0.049, z = -45.220 },
    { x = -67.474, y =  0.769, z = -41.325 },
    { x = -65.960, y =  1.182, z = -37.165 },
    { x = -53.524, y =  0.919, z = -41.377 },
    { x = -44.653, y =  0.000, z = -37.782 },
    { x = -63.130, y =  1.102, z = -39.680 },
    { x = -72.606, y =  0.322, z = -37.735 },
    { x = -59.438, y =  1.250, z = -39.216 },
    { x = -66.542, y =  1.042, z = -37.272 },
    { x = -44.681, y =  0.095, z = -35.371 },
    { x = -68.381, y =  0.860, z = -46.385 },
    { x = -74.592, y =  0.000, z = -40.162 },
    { x = -53.217, y =  0.873, z = -41.524 },
    { x = -43.462, y =  0.305, z = -43.662 },
    { x = -49.704, y =  0.500, z = -39.131 },
    { x = -65.262, y =  1.000, z = -39.255 },
    { x = -53.176, y =  1.441, z = -44.774 },
    { x = -47.472, y =  0.767, z = -48.368 },
    { x = -59.506, y =  1.250, z = -40.767 },
    { x = -71.863, y =  0.916, z = -32.397 },
    { x = -65.623, y =  1.000, z = -39.202 },
    { x = -71.756, y =  0.277, z = -43.637 },
    { x = -54.173, y =  1.000, z = -40.547 },
    { x = -51.520, y =  0.783, z = -34.539 },
    { x = -70.137, y =  0.482, z = -41.033 },
    { x = -79.187, y =  0.000, z = -42.264 },
    { x = -55.523, y =  1.000, z = -40.409 },
    { x = -68.824, y =  0.613, z = -40.931 },
    { x = -55.525, y =  1.000, z = -39.482 },
    { x = -50.468, y =  0.750, z = -32.678 },
    { x = -76.598, y =  0.000, z = -40.933 },
    { x = -67.128, y =  1.155, z = -36.524 },
    { x = -73.888, y =  0.000, z = -42.595 },
    { x = -73.698, y =  0.407, z = -31.263 },
    { x = -45.549, y =  0.413, z = -49.218 },
    { x = -72.305, y =  0.724, z = -30.201 },
    { x = -51.875, y =  0.672, z = -38.666 },
    { x = -44.344, y =  0.100, z = -35.128 },
    { x = -75.151, y =  0.309, z = -47.153 }
}

entity.phList =
{
    -- TODO: Two PH's should be in a spawn set along with the NM
    [ID.mob.CARGO_CRAB_COLIN + 22] = ID.mob.CARGO_CRAB_COLIN, -- -30.384 1.000 -33.277
    [ID.mob.CARGO_CRAB_COLIN + 24] = ID.mob.CARGO_CRAB_COLIN, -- -95.359 1.000 -34.375
}

entity.onMobInitialize = function(mob)
    mob:setMobMod(xi.mobMod.ADD_EFFECT, 1)
    mob:setMobMod(xi.mobMod.GIL_MIN, 1320)
    mob:setMobMod(xi.mobMod.GIL_MAX, 1320)
end

entity.onMobSpawn = function(mob)
    -- Has very high physical defense, takes normal damage from magic.
    mob:setMod(xi.mod.DEF, 300)
    mob:setMod(xi.mod.VIT, 25)
    mob:setMobMod(xi.mobMod.BASE_DAMAGE_MULTIPLIER, 150)
end

entity.onAdditionalEffect = function(mob, target, damage)
    return xi.mob.onAddEffect(mob, target, damage, xi.mob.ae.POISON, { power = 10 })
end

entity.onMobDeath = function(mob, player, optParams)
    xi.hunts.checkHunt(mob, player, 226)
end

entity.onMobDespawn = function(mob)
    xi.mob.updateNMSpawnPoint(mob)
end

return entity
