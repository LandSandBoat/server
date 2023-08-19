-----------------------------------
-- Area: RuAun Gardens
--  Mob: Air Elemental
-----------------------------------
local entity = {}

entity.onMobDeath = function(mob, player, optParams)
    xi.regime.checkRegime(player, mob, 145, 2, xi.regime.type.FIELDS)
end

return entity
