-----------------------------------
-- Area: King Ranperres Tomb
--  Mob: Pey
-----------------------------------
---@type TMobEntity
local entity = {}

entity.onMobSpawn = function(mob)
    mob:setSpawnAnimation(xi.spawnAnimation.SPECIAL)
end

return entity
