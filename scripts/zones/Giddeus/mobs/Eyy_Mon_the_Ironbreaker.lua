-----------------------------------
-- Area: Giddeus (145)
--   NM: Eyy Mon the Ironbreaker
-----------------------------------
local entity = {}

entity.onMobDeath = function(mob, player, isKiller)
end

entity.onMobDespawn = function(mob)
    if RESPAWN_SAVE_TIME then
        mob:setRespawnTime(math.random(RESPAWN_SAVE_TIME_MIN, RESPAWN_SAVE_TIME_MAX))
    else
        mob:setRespawnTime(math.random(900, 1200)) -- 15 to 20 minutes
    end
end

return entity
