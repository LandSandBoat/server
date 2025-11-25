-----------------------------------
-- Area: Waughroon Shrine
--  Mob: Metsanhaltija
-- BCNM: Grove Guardians
-----------------------------------
---@type TMobEntity
local entity = {}

entity.onMobInitialize = function(mob)
    mob:addImmunity(xi.immunity.DARK_SLEEP)
    mob:addImmunity(xi.immunity.LIGHT_SLEEP)
end

return entity
