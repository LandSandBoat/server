-----------------------------------
-- Area: Mamook
--  Mob: Brei
-----------------------------------
---@type TMobEntity
local entity = {}

entity.onMobSpawn = function(mob)
    mob:setMobMod(xi.mobMod.SEES_THROUGH_ILLUSION, 1)
end

return entity
