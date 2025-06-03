-----------------------------------
-- Area: Garlaige Citadel
--  Mob: Light Elemental
-----------------------------------
---@type TMobEntity
local entity = {}

entity.onMobInitialize = function(mob)
    mob:setMobMod(xi.mobMod.IDLE_DESPAWN, 300)
end

return entity
