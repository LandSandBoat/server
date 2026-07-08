-----------------------------------
-- Area: Halvung
--   NM: Dextrose (ZNM T2)
-----------------------------------
---@type TMobEntity
local entity = {}

entity.onMobInitialize = function(mob)
    mob:setMobMod(xi.mobMod.IDLE_DESPAWN, 900)
end

return entity
