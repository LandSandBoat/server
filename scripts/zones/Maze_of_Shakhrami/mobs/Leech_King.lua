-----------------------------------
-- Area: Maze of Shakhrami
--   NM: Leech King
-----------------------------------
local ID = zones[xi.zone.MAZE_OF_SHAKHRAMI]
-----------------------------------
---@type TMobEntity
local entity = {}

entity.spawnPoints =
{
    { x = 271.844, y = 18.887, z = -203.545 },
    { x = 243.469, y = 19.727, z = -196.274 },
    { x = 262.156, y = 19.973, z = -219.851 },
    { x = 281.575, y = 20.000, z = -241.118 },
    { x = 280.504, y = 21.000, z = -220.683 }
}

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
