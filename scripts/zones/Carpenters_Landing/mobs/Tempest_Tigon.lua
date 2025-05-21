-----------------------------------
-- Area: Carpenters' Landing
--   NM: Tempest Tigon
-----------------------------------
---@type TMobEntity
local entity = {}

local spawnPoints =
{
    { x = -246.387, y = -8.815, z = -328.821 },
    { x = -242.669, y = -6.587, z = -325.404 },
    { x = -235.198, y = -7.664, z = -328.223 },
    { x = -233.440, y = -5.777, z = -323.779 },
    { x = -225.261, y = -1.919, z = -319.403 },
    { x = -229.900, y = -3.537, z = -312.966 },
    { x = -238.429, y = -5.810, z = -317.978 },
    { x = -246.260, y = -6.904, z = -319.015 },
    { x = -251.544, y = -9.268, z = -314.962 },
    { x = -254.380, y = -8.773, z = -306.914 },
    { x = -245.998, y = -5.927, z = -306.152 },
    { x = -239.756, y = -5.427, z = -306.229 },
    { x = -233.707, y = -4.883, z = -306.695 },
    { x = -230.949, y = -4.208, z = -301.971 },
    { x = -238.613, y = -4.859, z = -300.505 },
    { x = -247.985, y = -7.002, z = -300.027 },
    { x = -251.733, y = -8.944, z = -293.391 },
    { x = -246.539, y = -6.583, z = -293.678 },
    { x = -240.079, y = -5.527, z = -292.926 },
    { x = -232.486, y = -3.338, z = -295.559 },
    { x = -226.640, y = -1.801, z = -293.027 },
    { x = -223.329, y = -1.595, z = -280.352 },
    { x = -229.511, y = -3.265, z = -278.078 },
    { x = -231.409, y = -2.838, z = -289.542 },
    { x = -237.841, y = -5.374, z = -291.264 },
    { x = -248.478, y = -7.322, z = -292.112 },
    { x = -250.022, y = -8.847, z = -285.780 },
    { x = -244.893, y = -6.209, z = -285.755 },
    { x = -237.803, y = -5.733, z = -281.786 },
    { x = -232.259, y = -4.369, z = -276.296 },
    { x = -230.497, y = -4.050, z = -270.854 },
    { x = -236.241, y = -5.327, z = -271.764 },
    { x = -243.589, y = -5.945, z = -274.885 },
    { x = -251.052, y = -8.156, z = -272.683 },
    { x = -249.949, y = -7.348, z = -266.621 },
    { x = -244.164, y = -5.474, z = -266.032 },
    { x = -236.055, y = -4.653, z = -262.816 },
    { x = -230.322, y = -3.887, z = -259.916 },
    { x = -230.871, y = -2.740, z = -251.924 },
    { x = -239.295, y = -5.044, z = -257.499 },
    { x = -248.701, y = -7.550, z = -251.007 },
    { x = -245.291, y = -6.506, z = -244.337 },
    { x = -239.080, y = -5.751, z = -246.801 },
    { x = -234.254, y = -4.990, z = -240.670 },
    { x = -245.152, y = -6.488, z = -240.812 },
    { x = -250.223, y = -9.045, z = -235.979 },
    { x = -243.119, y = -6.312, z = -235.325 },
    { x = -235.768, y = -8.443, z = -230.548 },
    { x = -239.622, y = -5.960, z = -242.606 },
    { x = -239.831, y = -5.162, z = -256.786 },
}

entity.onMobInitialize = function(mob)
    mob:setMobMod(xi.mobMod.ADD_EFFECT, 1)

    xi.mob.updateNMSpawnPoint(mob, spawnPoints)
    mob:setRespawnTime(math.random(900, 10800)) -- When server restarts, reset timer
end

entity.onAdditionalEffect = function(mob, target, damage)
    if math.random(1, 100) <= 50 then
        return xi.mob.onAddEffect(mob, target, damage, xi.mob.ae.ENAERO, { chance = 50 })
    else
        return xi.mob.onAddEffect(mob, target, damage, xi.mob.ae.ENWATER, { chance = 50 })
    end
end

entity.onMobDeath = function(mob, player, optParams)
    xi.hunts.checkHunt(mob, player, 168)
end

entity.onMobDespawn = function(mob)
    xi.mob.updateNMSpawnPoint(mob, spawnPoints)
    mob:setRespawnTime(math.random(3600, 7200)) -- 1 to 2 hours
end

return entity
