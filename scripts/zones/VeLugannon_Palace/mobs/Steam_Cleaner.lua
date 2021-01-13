-----------------------------------
-- Area: Ve'Lugannon Palace
--   NM: Steam Cleaner
-----------------------------------
local entity = {}

entity.onMobDeath = function(mob, player, isKiller)
end

function onMobDespawn(mob)
    mob:setRespawnTime(math.random(7200, 14400)) -- 2 to 4 hours
end

return entity
