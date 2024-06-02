-----------------------------------
-- Area: Newton Movalpolos
--   NM: Mimic
-----------------------------------
local entity = {}

entity.onMobInitialize = function(mob)
    mob:setMobMod(xi.mobMod.IDLE_DESPAWN, 120)
end

return entity
