-----------------------------------
-- Area: Batallia Downs (105)
--  Mob: Skirling Liger
-----------------------------------
---@type TMobEntity
local entity = {}

local spawnPoints =
{
    { x = -380.000, y = -16.000, z = 258.000 },
    { x = -429.000, y = -15.000, z = 240.000 },
    { x = -437.000, y = -15.000, z = 195.000 },
    { x = -401.000, y = -15.000, z = 173.000 },
    { x = -395.000, y = -15.000, z = 127.000 },
    { x = -337.000, y = -15.000, z = 115.000 },
    { x = -321.000, y = -15.000, z = 181.000 },
    { x = -377.000, y = -15.000, z = 204.000 },
}

entity.onMobInitialize = function(mob)
    xi.mob.updateNMSpawnPoint(mob, spawnPoints)
    mob:setRespawnTime(3600) -- 60 min
end

entity.onMobEngage = function(mob, target)
    mob:setMod(xi.mod.REGAIN, 50)
end

entity.onMobDisengage = function(mob)
    mob:setMod(xi.mod.REGAIN, 0)
end

entity.onMobDeath = function(mob, player, optParams)
    xi.hunts.checkHunt(mob, player, 162)
end

entity.onMobDespawn = function(mob)
    xi.mob.updateNMSpawnPoint(mob, spawnPoints)
    mob:setRespawnTime(3600) -- 60 min
end

return entity
