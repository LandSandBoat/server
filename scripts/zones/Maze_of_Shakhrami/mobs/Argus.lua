-----------------------------------
-- Area: Maze of Shakhrami
--   NM: Argus
-----------------------------------
local ID = zones[xi.zone.MAZE_OF_SHAKHRAMI]
-----------------------------------
---@type TMobEntity
local entity = {}

entity.spawnPoints =
{
    { x =  220.000, y =  18.800, z =  -64.000 },
    { x =  221.000, y =  20.000, z = -112.000 },
    { x =  244.000, y =  20.000, z =  -79.000 },
    { x =  272.000, y =  20.000, z =  -79.000 }
}

entity.onMobInitialize = function(mob)
    mob:addImmunity(xi.immunity.DARK_SLEEP)
    -- This handles BOTH Leech King and Argus init timers
    if math.randomInt(1, 100) <= 50 then
        DisallowRespawn(ID.mob.LEECH_KING, true)
        DisallowRespawn(ID.mob.ARGUS, false)
        xi.mob.updateNMSpawnPoint(ID.mob.ARGUS)
        GetMobByID(ID.mob.ARGUS):setRespawnTime(math.randomInt(900, 7200))
    else
        DisallowRespawn(ID.mob.ARGUS, true)
        DisallowRespawn(ID.mob.LEECH_KING, false)
        xi.mob.updateNMSpawnPoint(ID.mob.LEECH_KING)
        GetMobByID(ID.mob.LEECH_KING):setRespawnTime(math.randomInt(900, 7200))
    end
end

entity.onMobDespawn = function(mob)
    if math.randomInt(1, 100) <= 50 then
        DisallowRespawn(ID.mob.LEECH_KING, true)
        DisallowRespawn(ID.mob.ARGUS, false)
        xi.mob.updateNMSpawnPoint(ID.mob.ARGUS)
        GetMobByID(ID.mob.ARGUS):setRespawnTime(math.randomInt(3600, 7200)) -- 1-2 hours
    else
        DisallowRespawn(ID.mob.ARGUS, true)
        DisallowRespawn(ID.mob.LEECH_KING, false)
        xi.mob.updateNMSpawnPoint(ID.mob.LEECH_KING)
        GetMobByID(ID.mob.LEECH_KING):setRespawnTime(math.randomInt(3600, 7200)) -- 1-2 hours
    end
end

return entity
