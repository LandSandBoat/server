-----------------------------------
-- Area: The Shrine of Ru'Avitau
--  Mob: Faust
-- TODO: Faust should WS ~3 times in a row each time.
-----------------------------------
local entity = {}

function onMobDeath(mob, player, isKiller)
end

function onMobDespawn(mob)
    mob:setRespawnTime(math.random(10800, 21600)) -- respawn 3-6 hrs
end

return entity
