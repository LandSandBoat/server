-----------------------------------
-- Area: Hazhalm Testing Grounds
--   Mob: Craven Einherjar (Bhoot) (Einherjar)
-- Notes: Full immunity to Paralyze, 12 yalms standback
-----------------------------------
---@type TMobEntity
local entity = {}

entity.onMobInitialize = function(mob)
    mob:addImmunity(xi.immunity.PARALYZE)
    mob:setMobMod(xi.mobMod.STANDBACK_RANGE, 12)
    mob:setMobMod(xi.mobMod.MAGIC_COOL, 30)
end

return entity
