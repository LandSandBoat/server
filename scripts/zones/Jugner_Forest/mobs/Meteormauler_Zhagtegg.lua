-----------------------------------
-- Area: Jugner Forest
--   NM: Meteormauler Zhagtegg
-----------------------------------
local entity = {}

entity.onMobDeath = function(mob, player, isKiller)
end

function onMobDespawn(mob)
    mob:setRespawnTime(75600 + math.random(0, 600)) -- 21 hours, 10 minute window
end

return entity
