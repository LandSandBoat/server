-----------------------------------
-- Area: RuAun Gardens
--  Mob: Flamingo
-----------------------------------
require("scripts/globals/regimes")
-----------------------------------
local entity = {}

entity.onMobDeath = function(mob, player, isKiller)
    xi.regime.checkRegime(player, mob, 142, 1, xi.regime.type.FIELDS)
end

return entity
