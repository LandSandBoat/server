-----------------------------------
-- Area: Castle Oztroja [S]
--   NM: Marquis Forneus
-----------------------------------
mixins = { require('scripts/mixins/job_special') }
-----------------------------------
---@type TMobEntity
local entity = {}

entity.spawnPoints =
{
    { x = -343.345, y = -16.984, z =  141.193 }
}

entity.onMobInitialize = function(mob)
    xi.mob.updateNMSpawnPoint(mob)
    mob:setRespawnTime(math.randomInt(900, 10800))
end

entity.onMobDespawn = function(mob)
    xi.mob.updateNMSpawnPoint(mob)
    mob:setRespawnTime(math.randomInt(18000, 21600)) -- 5 to 6 hours
end

return entity
