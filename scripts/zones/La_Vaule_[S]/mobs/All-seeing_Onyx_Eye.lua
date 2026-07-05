-----------------------------------
-- Area: La Vaule [S]
--   NM: All-seeing Onyx Eye
-----------------------------------
---@type TMobEntity
local entity = {}

entity.onMobDespawn = function(mob)
    mob:setRespawnTime(math.randomInt(7200, 14400)) -- 2 to 4 hours
end

return entity
