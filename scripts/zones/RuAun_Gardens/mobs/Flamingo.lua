-----------------------------------
-- Area: RuAun Gardens
--  Mob: Flamingo
-----------------------------------
local entity = {}

entity.onMobDeath = function(mob, player, optParams)
    xi.regime.checkRegime(player, mob, 142, 1, xi.regime.type.FIELDS)
end

return entity
