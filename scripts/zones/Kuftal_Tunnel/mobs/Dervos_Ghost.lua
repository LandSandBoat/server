-----------------------------------
-- Area: Kuftal Tunnel
--   NM: Dervo's Ghost
-- Bastok mission 8-2
-----------------------------------
---@type TMobEntity
local entity = {}

entity.onMobInitialize = function(mob)
    mob:setMobMod(xi.mobMod.IDLE_DESPAWN, 180)
end

return entity
