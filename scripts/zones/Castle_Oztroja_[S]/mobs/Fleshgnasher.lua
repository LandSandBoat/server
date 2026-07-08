-----------------------------------
-- Area: Castle Oztroja [S]
--   NM: Fleshgnasher
-----------------------------------
mixins = { require('scripts/mixins/job_special') }
-----------------------------------
---@type TMobEntity
local entity = {}

entity.spawnPoints =
{
    { x =  174.370, y = -16.539, z = -141.226 }
}

entity.onMobInitialize = function(mob)
    xi.mob.updateNMSpawnPoint(mob)
    mob:setRespawnTime(math.randomInt(900, 10800))
end

entity.onMobDespawn = function(mob)
    xi.mob.updateNMSpawnPoint(mob)
    mob:setRespawnTime(math.randomInt(7200, 14400)) -- 2 to 4 hours
end

return entity
