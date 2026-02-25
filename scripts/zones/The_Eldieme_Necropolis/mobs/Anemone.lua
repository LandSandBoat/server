-----------------------------------
-- Area: The Eldieme Necropolis (195)
--   NM: Anemone
-----------------------------------
---@type TMobEntity
local entity = {}

entity.onMobInitialize = function(mob)
    mob:setRespawnTime(math.random(64800, 86400)) -- 18 to 24 hours
end

entity.onMobDespawn = function(mob)
    mob:setRespawnTime(math.random(64800, 86400)) -- 18 to 24 hours
end

return entity
