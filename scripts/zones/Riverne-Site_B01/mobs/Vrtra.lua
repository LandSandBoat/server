-----------------------------------
-- The Wyrmking Descends
-- Vrtra
-----------------------------------
local entity = {}

entity.onMobInitialize = function(mob)
    mob:setMobMod(xi.mobMod.DRAW_IN, 15)
end

return entity
