-----------------------------------
-- Area: East Ronfaure
--  Mob: Rambukk
-----------------------------------
---@type TMobEntity
local entity = {}

local spawnPoints =
{
    { x = 251.000, y = -20.000, z = -137.000 },
    { x = 291.000, y = -30.000, z = -114.000 },
    { x = 275.000, y = -31.000, z = -66.000  },
    { x = 257.000, y = -39.000, z = -27.000  },
    { x = 295.000, y = -40.000, z = -2.000   },
    { x = 350.000, y = -30.000, z = -41.000  },
    { x = 352.000, y = -20.000, z = -126.000 },
    { x = 180.000, y = -29.000, z = -73.000  },
    { x = 245.000, y = -39.000, z = 13.000   },
}

entity.onMobInitialize = function(mob)
    xi.mob.updateNMSpawnPoint(mob, spawnPoints)
    mob:setRespawnTime(math.random(900, 3600)) -- 15 min to 1 hour
end

entity.onMobDeath = function(mob, player, optParams)
    xi.hunts.checkHunt(mob, player, 152)
end

entity.onMobDespawn = function(mob)
    xi.mob.updateNMSpawnPoint(mob, spawnPoints)
    mob:setRespawnTime(math.random(900, 3600)) -- 15 min to 1 hour
end

return entity
