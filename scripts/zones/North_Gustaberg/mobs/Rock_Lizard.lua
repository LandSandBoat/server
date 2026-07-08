-----------------------------------
-- Area: North Gustaberg
--  Mob: Rock Lizard
-----------------------------------
---@type TMobEntity
local entity = {}

entity.onMobInitialize = function(mob)
    -- North Gustaberg lizards drop earth crystals
    mob:setCrystalElement(xi.element.EARTH)
end

entity.onMobDeath = function(mob, player, optParams)
    xi.regime.checkRegime(player, mob, 19, 2, xi.regime.type.FIELDS)
end

return entity
