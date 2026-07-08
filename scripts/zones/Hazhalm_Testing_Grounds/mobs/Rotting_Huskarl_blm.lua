-----------------------------------
-- Area: Hazhalm Testing Grounds
--   Mob: Rotting Huskarl (BLM) (Einherjar)
-- Notes: Full immunity to Dark Sleep. No standback.
-----------------------------------
---@type TMobEntity
local entity = {}

entity.onMobInitialize = function(mob)
    mob:addImmunity(xi.immunity.DARK_SLEEP)

    mob:setMobMod(xi.mobMod.NO_STANDBACK, 1)
    mob:setMobMod(xi.mobMod.MAGIC_DELAY, 0)
    mob:setMobMod(xi.mobMod.MAGIC_COOL, 25)
end

return entity
