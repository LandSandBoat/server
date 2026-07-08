-----------------------------------
-- Area: Hazhalm Testing Grounds
--   Mob: Berserkr (DRK) (Einherjar)
-- Notes: Immune to Petrify
-----------------------------------
---@type TMobEntity
local entity = {}

entity.onMobInitialize = function(mob)
    mob:addImmunity(xi.immunity.PETRIFY)

    mob:setMobMod(xi.mobMod.MAGIC_DELAY, 0)
    mob:setMobMod(xi.mobMod.MAGIC_COOL, 30)
end

return entity
