-----------------------------------
-- Area: Cape Teriggan
--   NM: Zmey Gorynych
-----------------------------------
---@type TMobEntity
local entity = {}

local spawnPoints =
{
    { x = -205.146, y = -1.047, z = 231.432 },
    { x = -194.067, y = -1.303, z = 231.401 },
    { x = -188.373, y = -1.907, z = 243.628 },
    { x = -196.377, y = -0.566, z = 248.861 },
    { x = -204.580, y = -0.045, z = 243.228 },
    { x = -211.208, y = -2.665, z = 251.127 },
    { x = -212.197, y = -1.902, z = 239.375 },
}

entity.onMobInitialize = function(mob)
    xi.mob.updateNMSpawnPoint(mob, spawnPoints)
    mob:setRespawnTime(math.random(3600, 7200)) -- 1 to 2 hours
    mob:setMod(xi.mod.TRIPLE_ATTACK, 45)
    mob:addMod(xi.mod.ATTP, 100)
    mob:addMod(xi.mod.ACC, 100)
end

entity.onMobDeath = function(mob, player, optParams)
    xi.hunts.checkHunt(mob, player, 406)
end

entity.onMobDespawn = function(mob)
    xi.mob.updateNMSpawnPoint(mob, spawnPoints)
    mob:setRespawnTime(math.random(3600, 7200)) -- 1-2 hours
end

return entity
