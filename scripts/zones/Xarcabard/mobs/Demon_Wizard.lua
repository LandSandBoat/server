-----------------------------------
-- Area: Xarcabard
--  Mob: Demon Wizard
-----------------------------------
require("scripts/globals/regimes")
-----------------------------------
local entity = {}

entity.onMobDeath = function(mob, player, isKiller)
    xi.regime.checkRegime(player, mob, 55, 1, xi.regime.type.FIELDS)
end

return entity
