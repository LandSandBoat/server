-----------------------------------
-- Area: Beadeaux (147)
--   NM: Go'Bhu Gascon
-----------------------------------
---@type TMobEntity
local entity = {}

entity.onMobDespawn = function(mob)
    mob:setRespawnTime(math.random(240, 360)) -- 4 to 6 minutes
end

return entity
