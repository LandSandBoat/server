-----------------------------------
-- Area: Giddeus (145)
--   NM: Eyy Mon the Ironbreaker
-----------------------------------
local entity = {}

entity.onMobDeath = function(mob, player, isKiller)
end

function onMobDespawn(mob)
    mob:setRespawnTime(math.random(900, 1200)) -- 15 to 20 minutes
end

return entity
