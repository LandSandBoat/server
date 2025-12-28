-----------------------------------
-- Area: Hazhalm Testing Grounds
--   Mob: Soulflayer (Einherjar)
-- Notes: Full immunity to blind and dark sleep
-----------------------------------
---@type TMobEntity
local entity = {}

entity.onMobInitialize = function(mob)
    mob:addImmunity(xi.immunity.BLIND)
    mob:addImmunity(xi.immunity.DARK_SLEEP)
end

return entity
