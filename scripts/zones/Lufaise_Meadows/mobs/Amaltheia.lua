-----------------------------------
-- Area: Lufaise Meadows
--   NM: Amaltheia
-----------------------------------
local entity = {}

entity.onMobInitialize = function(mob)
    mob:setMobMod(xi.mobMod.IDLE_DESPAWN, 120)
end

return entity
