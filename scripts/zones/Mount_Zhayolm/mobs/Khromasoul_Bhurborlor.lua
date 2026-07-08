-----------------------------------
-- Area: Mount Zhayolm
--  Mob: Khromasoul Bhurborlor (ZNM T3)
-----------------------------------
---@type TMobEntity
local entity = {}

entity.onMobInitialize = function(mob)
    mob:setMobMod(xi.mobMod.IDLE_DESPAWN, 300)
end

return entity
