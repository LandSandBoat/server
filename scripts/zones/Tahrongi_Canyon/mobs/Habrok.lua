-----------------------------------
-- Area: Tahrongi Canyon
--  Mob: Habrok
-----------------------------------
require('scripts/quests/tutorial')
-----------------------------------
---@type TMobEntity
local entity = {}

entity.spawnPoints =
{
    { x = -292.000, y =  15.000, z = -540.000 }
}

entity.onMobInitialize = function(mob)
    mob:setLocalVar('pop', GetSystemTime() + math.random(1200, 7200))
end

entity.onMobDeath = function(mob, player, optParams)
    xi.hunts.checkHunt(mob, player, 258)
    xi.tutorial.onMobDeath(player)
end

entity.onMobDespawn = function(mob)
    xi.mob.updateNMSpawnPoint(mob)
    mob:setLocalVar('pop', GetSystemTime() + math.random(1200, 7200))
end

return entity
