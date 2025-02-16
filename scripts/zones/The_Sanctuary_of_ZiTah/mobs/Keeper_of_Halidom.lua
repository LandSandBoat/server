-----------------------------------
-- Area: The Sanctuary of ZiTah
--   NM: Keeper of Halidom
-----------------------------------
---@type TMobEntity
local entity = {}

local spawnPoints =
{
    { x = 312.000, y = -0.500, z = 159.000 },
    { x = 352.304, y =  0.183, z = 198.403 },
    { x = 321.489, y =  0.033, z = 195.306 },
    { x = 303.480, y =  0.847, z = 169.473 },
    { x = 304.815, y =  0.563, z = 141.717 },
    { x = 325.957, y =  0.096, z = 157.485 },
}

entity.onMobInitialize = function(mob)
    xi.mob.updateNMSpawnPoint(mob, spawnPoints)
end

entity.onMobDeath = function(mob, player, optParams)
    xi.hunts.checkHunt(mob, player, 324)
    xi.magian.onMobDeath(mob, player, optParams, set{ 73, 287, 435 })
end

entity.onMobDespawn = function(mob)
    xi.mob.updateNMSpawnPoint(mob, spawnPoints)
end

return entity
