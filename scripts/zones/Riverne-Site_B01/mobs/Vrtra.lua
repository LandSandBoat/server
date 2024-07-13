-----------------------------------
-- The Wyrmking Descends
-- Vrtra
-----------------------------------
---@type TMobEntity
local entity = {}

entity.onMobInitialize = function(mob)
    mob:setMobMod(xi.mobMod.DRAW_IN_BITMASK, xi.drawin.NORMAL)
    mob:setMobMod(xi.mobMod.DRAW_IN_TRIGGER_DIST, 15)
end

return entity
