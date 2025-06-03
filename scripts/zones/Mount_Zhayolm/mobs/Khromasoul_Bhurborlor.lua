-----------------------------------
-- Area: Mount Zhayolm
--  Mob: Khromasoul Bhurborlor (ZNM T3)
-----------------------------------
---@type TMobEntity
local entity = {}

entity.onMobInitialize = function(mob)
    mob:setMobMod(xi.mobMod.IDLE_DESPAWN, 300)
end

entity.onMobDeath = function(mob, player, optParams)
end

return entity
