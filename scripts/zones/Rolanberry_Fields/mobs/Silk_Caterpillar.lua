-----------------------------------
-- Area: Rolanberry Fields
--   NM: Silk Caterpillar
-----------------------------------
---@type TMobEntity
local entity = {}

entity.onMobDespawn = function(mob)
    UpdateNMSpawnPoint(mob:getID())
end

return entity
