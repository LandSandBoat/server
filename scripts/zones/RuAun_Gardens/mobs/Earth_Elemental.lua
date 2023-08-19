-----------------------------------
-- Area: RuAun Gardens
--  Mob: Earth Elemental
-----------------------------------
local entity = {}

entity.onMobDeath = function(mob, player, optParams)
    xi.regime.checkRegime(player, mob, 146, 2, xi.regime.type.FIELDS)
end

return entity
