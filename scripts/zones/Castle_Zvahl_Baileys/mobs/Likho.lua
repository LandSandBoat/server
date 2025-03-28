-----------------------------------
-- Area: Castle Zvahl Baileys (161)
--   NM: Likho
-----------------------------------
---@type TMobEntity
local entity = {}

local spawnPoints =
{
    { x = 141.130, y = -24.030, z = 60.870 },
    { x = 135.592, y = -24.008, z = 54.487 },
    { x = 134.865, y = -24.026, z = 63.909 },
    { x = 146.538, y = -24.121, z = 64.656 },
    { x = 145.965, y = -24.031, z = 55.007 },
    { x = 141.460, y = -24.067, z = 58.680 },
}

entity.onMobInitialize = function(mob)
    xi.mob.updateNMSpawnPoint(mob, spawnPoints)
    mob:setRespawnTime(math.random(3600, 4200))
end

entity.onMobSpawn = function(mob)
    mob:addImmunity(xi.immunity.DARK_SLEEP)
    mob:addImmunity(xi.immunity.LIGHT_SLEEP)
    mob:addImmunity(xi.immunity.TERROR)
    mob:addImmunity(xi.immunity.GRAVITY)
    mob:addImmunity(xi.immunity.BIND)
    mob:addImmunity(xi.immunity.SILENCE)
end

entity.onMobDeath = function(mob, player, optParams)
    xi.hunts.checkHunt(mob, player, 351)
end

entity.onMobDespawn = function(mob)
    xi.mob.updateNMSpawnPoint(mob, spawnPoints)
    mob:setRespawnTime(math.random(3600, 4200)) -- 60 to 70 minutes
end

return entity
