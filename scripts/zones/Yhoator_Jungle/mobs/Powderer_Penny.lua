-----------------------------------
-- Area: Yhoator Jungle (124)
--   NM: Powderer Penny
--   WOTG Nov 2009 NM: Immune to Bind, Sleep, Gravity. Uses only 1 TP move.
-----------------------------------
---@type TMobEntity
local entity = {}

entity.spawnPoints =
{
    { x = -11.700, y = -2.531, z = -123.250 },
    { x =  -3.466, y = -0.500, z =  -65.710 },
    { x =   5.283, y = -3.164, z =  -95.762 },
    { x = -15.146, y = -0.698, z = -145.681 },
    { x = -15.742, y =  8.204, z = -102.386 },
    { x = -46.099, y = -0.144, z =  -65.964 },
    { x = -37.681, y = -3.300, z = -124.244 }
}

entity.onMobInitialize = function(mob)
    xi.mob.updateNMSpawnPoint(mob)
    mob:setRespawnTime(math.random(5400, 7200)) -- 1.5 to 2 hours
end

entity.onMobSpawn = function(mob)
    mob:addImmunity(xi.immunity.LIGHT_SLEEP)
    mob:addImmunity(xi.immunity.DARK_SLEEP)
    mob:addImmunity(xi.immunity.GRAVITY)
    mob:addImmunity(xi.immunity.BIND)
    mob:setMod(xi.mod.STORETP, 10)
end

entity.onMobDeath = function(mob, player, optParams)
    xi.hunts.checkHunt(mob, player, 365)
end

entity.onMobDespawn = function(mob)
    xi.mob.updateNMSpawnPoint(mob)
    mob:setRespawnTime(math.random(5400, 7200)) -- 1.5 to 2 hours
end

return entity
