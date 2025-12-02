-----------------------------------
-- Area: Buburimu Peninsula
--   NM: Wake Warder Wanda
-----------------------------------
---@type TMobEntity
local entity = {}

entity.spawnPoints =
{
    { x = -113.000, y =  20.000, z = -317.000 },
    { x =  -80.000, y =  20.000, z = -324.000 },
    { x =  -44.000, y =  20.000, z = -314.000 },
    { x =  -42.000, y =  16.000, z = -267.000 },
    { x =   -4.000, y =  16.000, z = -212.000 },
    { x =  -59.000, y =  16.000, z = -232.000 },
    { x = -111.000, y =  16.000, z = -246.000 },
    { x =  -73.000, y =  16.000, z = -270.000 }
}

entity.spawnPoints =
{
    { x = -113.000, y =  20.000, z = -317.000 },
    { x =  -80.000, y =  20.000, z = -324.000 },
    { x =  -44.000, y =  20.000, z = -314.000 },
    { x =  -42.000, y =  16.000, z = -267.000 },
    { x =   -4.000, y =  16.000, z = -212.000 },
    { x =  -59.000, y =  16.000, z = -232.000 },
    { x = -111.000, y =  16.000, z = -246.000 },
    { x =  -73.000, y =  16.000, z = -270.000 },
}

entity.onMobInitialize = function(mob)
    xi.mob.updateNMSpawnPoint(mob)
    mob:setRespawnTime(math.random(3600, 4200)) -- When server restarts, reset timer

    mob:setMobMod(xi.mobMod.MAGIC_COOL, 50) -- just one spell to spam
end

entity.onMobEngage = function(mob, target)
    mob:setMod(xi.mod.REGAIN, 25)
end

entity.onMobDisengage = function(mob)
    mob:setMod(xi.mod.REGAIN, 0)
end

entity.onMobDeath = function(mob, player, optParams)
    xi.hunts.checkHunt(mob, player, 260)
end

entity.onMobDespawn = function(mob)
    xi.mob.updateNMSpawnPoint(mob)
    mob:setRespawnTime(math.random(3600, 4200)) -- repop 60-70min
end

return entity
