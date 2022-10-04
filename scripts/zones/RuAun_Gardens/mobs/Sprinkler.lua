-----------------------------------
-- Area: RuAun Gardens
--  Mob: Sprinkler
-----------------------------------
require("scripts/globals/regimes")
-----------------------------------
local entity = {}

entity.onMobDeath = function(mob, player, optParams)
    xi.regime.checkRegime(player, mob, 142, 2, xi.regime.type.FIELDS)
    xi.regime.checkRegime(player, mob, 143, 1, xi.regime.type.FIELDS)
end

return entity
