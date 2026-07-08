-----------------------------------
-- Area: Ordelle's Caves
--  Mob: Aroma Leech
-----------------------------------
---@type TMobEntity
local entity = {}

entity.onMobInitialize = function(mob)
    mob:setMobMod(xi.mobMod.IDLE_DESPAWN, 300)
end

return entity
