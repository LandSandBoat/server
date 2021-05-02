-----------------------------------
-- Area: Ranguemont Pass
--   NM: Mucoid Mass
-----------------------------------
require("scripts/globals/hunts")
-----------------------------------
local entity = {}

entity.onMobDeath = function(mob, player, isKiller)
    xi.hunts.checkHunt(mob, player, 345)
end

entity.onMobDespawn = function(mob)
    if RESPAWN_SAVE_TIME then
        mob:setRespawnTime(math.random(RESPAWN_SAVE_TIME_MIN, RESPAWN_SAVE_TIME_MAX))
    else
        mob:setRespawnTime(math.random(5400, 6000)) -- 90 to 100 minutes
    end
end

return entity
