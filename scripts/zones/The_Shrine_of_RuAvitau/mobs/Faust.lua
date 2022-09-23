-----------------------------------
-- Area: The Shrine of Ru'Avitau
--  Mob: Faust
-- TODO: Faust should WS ~3 times in a row each time.
-----------------------------------
local entity = {}

entity.onMobDeath = function(mob, player, isKiller)
end

entity.onMobDespawn = function(mob)
    mob:setRespawnTime(math.random(10800, 21600)) -- respawn 3-6 hrs
end

return entity
