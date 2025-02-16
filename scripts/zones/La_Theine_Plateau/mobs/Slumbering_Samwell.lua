-----------------------------------
-- Area: La Theine Plateau
--   NM: Slumbering Samwell
-----------------------------------
---@type TMobEntity
local entity = {}

local spawnPoints =
{
    { x = 65.000,  y = 16.000, z = 149.000 },
    { x = 62.000,  y = 16.000, z = 95.000  },
    { x = 33.000,  y = 16.000, z = 51.000  },
    { x = -45.000, y = 16.000, z = 78.000  },
    { x = -49.000, y = 17.000, z = 107.000 },
    { x = -81.000, y = 16.000, z = 150.000 },
    { x = -29.000, y = 16.000, z = 149.000 },
    { x = 46.000,  y = 16.000, z = 155.000 },
}

entity.onMobInitialize = function(mob)
    xi.mob.updateNMSpawnPoint(mob, spawnPoints)
    mob:setRespawnTime(3600) -- 20 min
end

entity.onMobSpawn = function(mob)
    mob:setMod(xi.mod.REGAIN, 33)
end

entity.onMobDeath = function(mob, player, optParams)
    xi.hunts.checkHunt(mob, player, 155)
    xi.mob.updateNMSpawnPoint(mob, spawnPoints)
    mob:setRespawnTime(3600) -- 20 min
end

return entity
