-----------------------------------
-- Area: Hazhalm Testing Grounds
--   Mob: Liquified Einherjar (Einherjar)
-- Notes: No delay on magic, then every 25 seconds.
-----------------------------------
---@type TMobEntity
local entity = {}

entity.onMobInitialize = function(mob)
    mob:setMobMod(xi.mobMod.MAGIC_DELAY, 0)
    mob:setMobMod(xi.mobMod.MAGIC_COOL, 25)
end

return entity
