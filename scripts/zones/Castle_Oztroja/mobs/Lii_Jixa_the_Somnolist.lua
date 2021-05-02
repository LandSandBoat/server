-----------------------------------
-- Area: Castle Oztroja (151)
--   NM: Lii Jixa the Somnolist
-----------------------------------
require("scripts/globals/hunts")
mixins = {require("scripts/mixins/job_special")}
-----------------------------------
local entity = {}

entity.onMobDeath = function(mob, player, isKiller)
    xi.hunts.checkHunt(mob, player, 306)
end

entity.onMobDespawn = function(mob)
    if RESPAWN_SAVE_TIME then
        mob:setRespawnTime(math.random(RESPAWN_SAVE_TIME_MIN, RESPAWN_SAVE_TIME_MAX))
    else
        mob:setRespawnTime(math.random(3600, 5400)) -- 60 to 90 minutes
    end
end

return entity
