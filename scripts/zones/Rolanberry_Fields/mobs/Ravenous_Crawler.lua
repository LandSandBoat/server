-----------------------------------
-- Area: Rolanberry Fields
--   NM: Ravenous Crawler
-----------------------------------
---@type TMobEntity
local entity = {}

entity.spawnPoints =
{
    { x = -488.800, y =  -8.000, z =  -37.888 },
    { x = -454.893, y =  -8.368, z =  -81.525 },
    { x = -491.944, y = -15.695, z = -125.229 },
    { x = -493.331, y = -15.787, z =  -90.428 },
    { x = -521.266, y = -15.929, z =  -74.551 },
    { x = -513.025, y = -16.239, z =  -49.851 },
    { x = -527.306, y = -16.432, z =  -19.056 },
    { x = -562.343, y = -16.082, z =  -35.952 },
}

entity.onMobSpawn = function(mob)
    mob:addImmunity(xi.immunity.LIGHT_SLEEP)
    mob:addImmunity(xi.immunity.DARK_SLEEP)
    mob:addImmunity(xi.immunity.GRAVITY)
    mob:addImmunity(xi.immunity.BIND)
    mob:setMod(xi.mod.STORETP, 50)
end

entity.onMobDeath = function(mob, player, optParams)
    xi.hunts.checkHunt(mob, player, 217)
end

entity.onMobDespawn = function(mob)
    xi.mob.updateNMSpawnPoint(mob)
end

return entity
