-----------------------------------
-- Area: Giddeus (145)
--   NM: Eyy Mon the Ironbreaker
-----------------------------------
local entity = {}

entity.onMobDeath = function(mob, player, optParams)
end

entity.onMobDespawn = function(mob)
    mob:setRespawnTime(math.random(900, 1200)) -- 15 to 20 minutes
end

return entity
