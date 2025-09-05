-----------------------------------
-- Area: King Ranperre's Tomb
--   NM: Barbastelle
-----------------------------------
---@type TMobEntity
local entity = {}

entity.spawnPoints =
{
    { x =  133.000, y = -0.500, z =  220.000 }
}

entity.onMobInitialize = function(mob)
    xi.mob.updateNMSpawnPoint(mob)
    mob:setRespawnTime(math.random(1800, 5400))
end

entity.onMobDeath = function(mob, player, optParams)
    xi.hunts.checkHunt(mob, player, 175)
    xi.magian.onMobDeath(mob, player, optParams, set{ 512 })
end

entity.onMobDespawn = function(mob)
    xi.mob.updateNMSpawnPoint(mob)
    mob:setRespawnTime(math.random(1800, 5400)) -- 30 to 90 minutes
end

return entity
