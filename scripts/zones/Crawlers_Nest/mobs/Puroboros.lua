-----------------------------------
-- Area: Crawlers' Nest
--  Mob: Puroboros
-----------------------------------
local entity = {}

entity.onMobDeath = function(mob, player, optParams)
end

entity.onMobDespawn = function(mob)
    mob:setRespawnTime(math.random(3600, 10800)) -- 1 to 3 hours
end

return entity
