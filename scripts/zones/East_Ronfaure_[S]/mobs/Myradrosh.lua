-----------------------------------
-- Area: East Ronfaure [S]
--   NM: Myradrosh
-----------------------------------
---@type TMobEntity
local entity = {}

entity.spawnPoints =
{
    { x =  470.000, y = -18.000, z = -241.000 }
}

entity.onMobInitialize = function(mob)
    xi.mob.updateNMSpawnPoint(mob)
    mob:setRespawnTime(math.random(5400, 7200))
    mob:addMod(xi.mod.REGAIN, 50)
end

entity.onMobDeath = function(mob, player, optParams)
    xi.hunts.checkHunt(mob, player, 480)
end

entity.onMobDespawn = function(mob)
    xi.mob.updateNMSpawnPoint(mob)
    mob:setRespawnTime(math.random(5400, 7200)) -- 90 to 120 minutes
end

return entity
