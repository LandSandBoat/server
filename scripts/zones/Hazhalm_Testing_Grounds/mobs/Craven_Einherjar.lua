-----------------------------------
-- Area: Hazhalm Testing Grounds
--   Mob: Craven Einherjar (Einherjar)
-- Notes: Full immunity to Paralyze, 12 yalms standback
-----------------------------------
---@type TMobEntity
local entity = {}

entity.onMobInitialize = function(mob)
    mob:addImmunity(xi.immunity.PARALYZE)
    mob:setMobMod(xi.mobMod.STANDBACK_RANGE, 12)
end

return entity
