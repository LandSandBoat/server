-----------------------------------
-- Area: Maze of Shakhrami
--   NM: Leech King
-----------------------------------
local ID = require("scripts/zones/Maze_of_Shakhrami/IDs")
-----------------------------------
local entity = {}

entity.onMobDeath = function(mob, player, isKiller)
end

entity.onMobDespawn = function(mob)
    if math.random(2) == 1 then
        DisallowRespawn(ID.mob.LEECH_KING, true)
        DisallowRespawn(ID.mob.ARGUS, false)
        UpdateNMSpawnPoint(ID.mob.ARGUS)
        if RESPAWN_SAVE_TIME then
            GetMobByID(ID.mob.ARGUS):setRespawnTime(math.random(RESPAWN_SAVE_TIME_MIN, RESPAWN_SAVE_TIME_MAX))
        else
            GetMobByID(ID.mob.ARGUS):setRespawnTime(math.random(3600, 7200)) -- 1-2 hours
        end
    else
        DisallowRespawn(ID.mob.ARGUS, true)
        DisallowRespawn(ID.mob.LEECH_KING, false)
        UpdateNMSpawnPoint(ID.mob.LEECH_KING)
        if RESPAWN_SAVE_TIME then
            GetMobByID(ID.mob.LEECH_KING):setRespawnTime(math.random(RESPAWN_SAVE_TIME_MIN, RESPAWN_SAVE_TIME_MAX))
        else
            GetMobByID(ID.mob.LEECH_KING):setRespawnTime(math.random(3600, 7200)) -- 1-2 hours
        end
    end
end

return entity
