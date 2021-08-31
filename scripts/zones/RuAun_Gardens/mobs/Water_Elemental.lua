-----------------------------------
-- Area: RuAun Gardens
--  Mob: Water Elemental
-----------------------------------
require("scripts/globals/regimes")
-----------------------------------
local entity = {}

entity.onMobDeath = function(mob, player, isKiller)
    xi.regime.checkRegime(player, mob, 146, 3, xi.regime.type.FIELDS)
end

return entity
