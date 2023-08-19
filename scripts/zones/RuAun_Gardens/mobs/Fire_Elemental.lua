-----------------------------------
-- Area: RuAun Gardens
--  Mob: Fire Elemental
-----------------------------------
local entity = {}

entity.onMobDeath = function(mob, player, optParams)
    xi.regime.checkRegime(player, mob, 145, 1, xi.regime.type.FIELDS)
end

return entity
