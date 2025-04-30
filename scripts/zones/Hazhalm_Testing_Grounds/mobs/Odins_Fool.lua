-----------------------------------
-- Area: Hazhalm Testing Grounds
--   Mob: Odin's Fool (Einherjar)
-- Notes: 20 seconds between casts.
-----------------------------------
---@type TMobEntity
local entity = {}

entity.onMobInitialize = function(mob)
    mob:setMobMod(xi.mobMod.MAGIC_COOL, 20)
end

return entity
