-----------------------------------
-- Area: Mamook
--   NM: Dragonscaled Bugaal Ja
-----------------------------------
local entity = {}

entity.onMobDeath = function(mob, player, optParams)
end

entity.onMobDespawn = function(mob)
    UpdateNMSpawnPoint(mob:getID())
    mob:setRespawnTime(math.random(100800, 259200)) -- 28 to 72 hours
end

return entity
