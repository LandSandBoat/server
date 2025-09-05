-----------------------------------
-- Area: Bostaunieux Oubliette (167)
--   NM: Shii
-----------------------------------
local ID = zones[xi.zone.BOSTAUNIEUX_OUBLIETTE]
-----------------------------------
---@type TMobEntity
local entity = {}

entity.spawnPoints =
{
    { x = -59.000, y =  0.941, z = -149.000 },
    { x = -64.000, y = -0.500, z = -144.000 },
    { x = -65.000, y = -1.000, z = -137.000 },
    { x = -64.000, y =  0.950, z = -132.000 },
    { x = -53.000, y = -0.500, z = -137.000 },
    { x = -57.000, y =  0.998, z = -135.000 },
    { x = -65.866, y =  0.000, z = -142.365 },
    { x = -64.572, y =  0.000, z = -144.864 },
    { x = -53.924, y =  0.031, z = -137.069 },
    { x = -63.334, y =  0.022, z = -131.785 },
    { x = -65.001, y =  0.000, z = -133.664 },
    { x = -58.166, y =  0.006, z = -133.472 },
    { x = -66.081, y = -0.002, z = -134.929 },
    { x = -53.025, y =  0.000, z = -140.871 },
    { x = -61.316, y =  0.023, z = -147.906 },
    { x = -59.452, y =  0.042, z = -149.259 },
    { x = -54.721, y =  0.018, z = -134.543 },
    { x = -64.042, y =  0.025, z = -146.436 },
    { x = -55.893, y =  0.125, z = -132.174 },
    { x = -67.224, y =  0.000, z = -137.165 },
    { x = -65.077, y =  0.000, z = -134.253 },
    { x = -60.878, y =  0.000, z = -134.248 },
    { x = -60.888, y =  0.000, z = -133.621 },
    { x = -52.779, y =  0.021, z = -135.872 },
    { x = -60.216, y =  0.031, z = -148.843 },
    { x = -51.298, y = -0.019, z = -140.171 },
    { x = -59.893, y =  0.049, z = -148.614 },
    { x = -51.888, y =  0.000, z = -140.972 },
    { x = -63.372, y =  0.000, z = -134.574 },
    { x = -62.464, y =  0.028, z = -147.034 },
    { x = -56.823, y =  0.070, z = -133.063 },
    { x = -61.871, y =  0.000, z = -133.804 },
    { x = -66.121, y = -0.003, z = -134.873 },
    { x = -65.987, y = -0.001, z = -140.197 },
    { x = -54.498, y = -0.003, z = -138.073 },
    { x = -53.920, y =  0.017, z = -137.471 },
    { x = -52.869, y =  0.000, z = -134.519 },
    { x = -54.009, y =  0.000, z = -139.217 },
    { x = -53.138, y =  0.000, z = -141.360 },
    { x = -63.537, y =  0.000, z = -135.494 },
    { x = -65.972, y =  0.011, z = -146.409 },
    { x = -63.990, y =  0.000, z = -133.379 },
    { x = -67.764, y =  0.011, z = -135.735 },
    { x = -57.020, y =  0.000, z = -137.409 },
    { x = -57.316, y =  0.000, z = -148.094 },
    { x = -56.425, y =  0.000, z = -135.226 },
    { x = -55.742, y = -0.028, z = -134.050 },
    { x = -66.461, y = -0.010, z = -134.514 },
    { x = -65.734, y =  0.000, z = -133.094 },
    { x = -65.300, y =  0.000, z = -144.027 }
}

entity.phList =
{
    [ID.mob.SHII - 38] = ID.mob.SHII, -- -65.000 -1.000 -137.000
    [ID.mob.SHII - 7]  = ID.mob.SHII, -- -57.000 0.998 -135.000
    [ID.mob.SHII - 6]  = ID.mob.SHII, -- -64.000 0.950 -132.000
    [ID.mob.SHII - 4]  = ID.mob.SHII, -- -59.000 0.941 -149.000
    [ID.mob.SHII - 3]  = ID.mob.SHII, -- -53.000 -0.500 -137.000
    [ID.mob.SHII + 19] = ID.mob.SHII, -- -64.000 -0.500 -144.000
}

entity.onMobInitialize = function(mob)
    mob:setMobMod(xi.mobMod.ADD_EFFECT, 1) -- "has an Additional Effect: Terror in melee attacks"
    mob:setMod(xi.mod.REGEN, 20) -- "also has an Auto Regen of medium strength" (guessing 20)
end

entity.onAdditionalEffect = function(mob, target, damage)
    return xi.mob.onAddEffect(mob, target, damage, xi.mob.ae.TERROR)
end

entity.onMobRoam = function(mob)
    if VanadielHour() >= 6 and VanadielHour() < 18 then -- Despawn if its day
        DespawnMob(mob:getID())
    end
end

entity.onMobDeath = function(mob, player, optParams)
    xi.hunts.checkHunt(mob, player, 179)
end

return entity
