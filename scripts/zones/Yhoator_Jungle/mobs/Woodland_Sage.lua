-----------------------------------
-- Area: Yhoator Jungle (124)
--   NM: Woodland Sage
-----------------------------------
mixins = {require("scripts/mixins/job_special")}
-----------------------------------
local entity = {}

entity.onMobDeath = function(mob, player, isKiller)
end

entity.onMobDespawn = function(mob)
    -- Set Woodland_Sage's spawnpoint and respawn time (21-24 hours)
    UpdateNMSpawnPoint(mob:getID())
    if RESPAWN_SAVE_TIME then
        mob:setRespawnTime(math.random(RESPAWN_SAVE_TIME_MIN, RESPAWN_SAVE_TIME_MAX))
    else
        mob:setRespawnTime(math.random(75600, 86400))
    end
end

return entity
