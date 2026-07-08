-----------------------------------
-- Area: Korroloka Tunnel
--  NM: Jammer Leech
-----------------------------------
---@type TMobEntity
local entity = {}

entity.onMobInitialize = function(mob)
    mob:setRespawnTime(math.randomInt(600, 1800)) -- 10-30 minutes
end

entity.onMobDespawn = function(mob)
    mob:setRespawnTime(math.randomInt(600, 1800)) -- 10-30 minutes
end

return entity
