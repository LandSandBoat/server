-----------------------------------
-- Area: Hazhalm Testing Grounds
--   Mob: Vanquished Einherjar (BLM) (Einherjar)
-- Notes: Full immunity to dark sleep
-----------------------------------
---@type TMobEntity
local entity = {}

entity.onMobInitialize = function(mob)
    mob:addImmunity(xi.immunity.DARK_SLEEP)
end

return entity
