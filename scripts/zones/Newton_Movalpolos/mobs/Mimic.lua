-----------------------------------
-- Area: Newton Movalpolos
--   NM: Mimic
-----------------------------------
---@type TMobEntity
local entity = {}

entity.onMobInitialize = function(mob)
    mob:setMobMod(xi.mobMod.IDLE_DESPAWN, 120)
end

return entity
