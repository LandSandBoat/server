-----------------------------------
-- Area: Batallia Downs (105)
--  Mob: Ahtu
-----------------------------------
---@type TMobEntity
local entity = {}

entity.onMobInitialize = function(mob)
    mob:setRespawnTime(math.randomInt(7200, 14400)) -- 2-4 hours
end

entity.onMobDespawn = function(mob)
    mob:setRespawnTime(math.randomInt(7200, 14400)) -- 2-4 hours
end

return entity
