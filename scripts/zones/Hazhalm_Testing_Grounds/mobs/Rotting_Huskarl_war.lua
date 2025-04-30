-----------------------------------
-- Area: Hazhalm Testing Grounds
--   Mob: Rotting Huskarl (WAR) (Einherjar)
-- Notes: Full immunity to Dark Sleep.
-----------------------------------
---@type TMobEntity
local entity = {}

entity.onMobInitialize = function(mob)
    mob:addImmunity(xi.immunity.DARK_SLEEP)
end

return entity
