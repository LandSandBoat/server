-----------------------------------
-- Area: The Shrine of Ru'Avitau
--  Mob: Faust
-- TODO: Faust should WS ~3 times in a row each time.
-----------------------------------
local entity = {}

entity.onMobDeath = function(mob, player, isKiller)
end

entity.onMobDespawn = function(mob)
    if RESPAWN_SAVE_TIME then
        mob:setRespawnTime(math.random(RESPAWN_SAVE_TIME_MIN, RESPAWN_SAVE_TIME_MAX))
    else
        mob:setRespawnTime(math.random(10800, 21600)) -- respawn 3-6 hrs
    end
end

return entity
