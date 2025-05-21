-----------------------------------
-- Area: Hazhalm Testing Grounds
--   Mob: Dark Elemental (Einherjar)
-- Notes: Full immunity to blind and dark sleep.
-- Aggro by sound and magic.
-----------------------------------
---@type TMobEntity
local entity = {}

entity.onMobInitialize = function(mob)
    mob:addImmunity(xi.immunity.BLIND)
    mob:addImmunity(xi.immunity.DARK_SLEEP)

    mob:setMobMod(xi.mobMod.DETECTION, bit.bor(xi.detects.MAGIC, xi.detects.HEARING))
    mob:setMobMod(xi.mobMod.MAGIC_DELAY, 0)
    mob:setMobMod(xi.mobMod.MAGIC_COOL, 30)
end

return entity
