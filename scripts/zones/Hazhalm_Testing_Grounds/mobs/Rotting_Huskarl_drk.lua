-----------------------------------
-- Area: Hazhalm Testing Grounds
--   Mob: Rotting Huskarl (DRK) (Einherjar)
-- Notes: Full immunity to Dark Sleep.
-- No magic delay, then every 30 seconds.
-----------------------------------
---@type TMobEntity
local entity = {}

entity.onMobInitialize = function(mob)
    mob:addImmunity(xi.immunity.DARK_SLEEP)

    mob:setMobMod(xi.mobMod.MAGIC_DELAY, 0)
    mob:setMobMod(xi.mobMod.MAGIC_COOL, 30)
end

return entity
