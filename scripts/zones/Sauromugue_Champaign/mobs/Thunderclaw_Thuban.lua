-----------------------------------
-- Area: Sauromugue Champaign
--   NM: Thunderclaw Thuban
-----------------------------------
---@type TMobEntity
local entity = {}

entity.spawnPoints =
{
    { x =  423.313, y =  16.568, z = -110.108 }
}

entity.onMobDeath = function(mob, player, optParams)
    xi.hunts.checkHunt(mob, player, 274)
end

entity.onMobDespawn = function(mob)
    xi.mob.updateNMSpawnPoint(mob)
    mob:setRespawnTime(math.random(5400, 7200)) -- 90 to 120 minutes
end

return entity
