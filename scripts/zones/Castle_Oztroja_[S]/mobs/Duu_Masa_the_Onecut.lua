-----------------------------------
-- Area: Castle Oztroja [S]
--   NM: Duu Masa the Onecut
-----------------------------------
mixins = { require('scripts/mixins/job_special') }
-----------------------------------
---@type TMobEntity
local entity = {}

entity.spawnPoints =
{
    { x = -228.000, y = -0.680, z =  148.000 }
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
