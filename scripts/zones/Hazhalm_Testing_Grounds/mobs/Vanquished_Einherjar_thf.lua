-----------------------------------
-- Area: Hazhalm Testing Grounds
--   Mob: Vanquished Einherjar (THF) (Einherjar)
-- Notes: Immune to Dark Sleep
-----------------------------------
---@type TMobEntity
local entity = {}

entity.onMobInitialize = function(mob)
    mob:addImmunity(xi.immunity.DARK_SLEEP)
end

return entity
