-----------------------------------
-- Area: Crawlers' Nest
--  Mob: Puroboros
-----------------------------------
---@type TMobEntity
local entity = {}

entity.onMobDespawn = function(mob)
    mob:setRespawnTime(math.randomInt(3600, 10800)) -- 1 to 3 hours
end

return entity
