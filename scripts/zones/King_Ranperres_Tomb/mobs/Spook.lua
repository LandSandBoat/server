-----------------------------------
-- Area: King Ranperres Tomb
--  Mob: Spook
-----------------------------------
local entity = {}

entity.onMobDespawn = function(mob)
    UpdateNMSpawnPoint(mob:getID())
end

return entity
