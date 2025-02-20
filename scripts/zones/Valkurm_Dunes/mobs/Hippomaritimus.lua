-----------------------------------
-- Area: Valkurm Dunes
--  Mob: Hippomaritimus
-----------------------------------
---@type TMobEntity
local entity = {}

local spawnPoints =
{
    { x = 238.000, y = 4.000, z = -163.000 },
    { x = 289.000, y = 4.000, z = -168.000 },
    { x = 326.000, y = 4.000, z = -171.000 },
    { x = 346.000, y = 3.000, z = -150.000 },
    { x = 351.000, y = 4.000, z = -198.000 },
}

entity.onMobInitialize = function(mob)
    xi.mob.updateNMSpawnPoint(mob, spawnPoints)
    mob:setRespawnTime(math.random(3600, 5400)) -- 60-90 min repop
end

entity.onMobDeath = function(mob, player, optParams)
    xi.hunts.checkHunt(mob, player, 210)
end

entity.onMobDespawn = function(mob)
    xi.mob.updateNMSpawnPoint(mob, spawnPoints)
    mob:setRespawnTime(math.random(3600, 5400)) -- 60-90 min repop
end

return entity
