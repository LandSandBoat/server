-----------------------------------
-- Area: Xarcabard
--  Mob: Etemmu
-----------------------------------
require("scripts/globals/regimes")
-----------------------------------
local entity = {}

entity.onMobDeath = function(mob, player, isKiller)
    xi.regime.checkRegime(player, mob, 51, 2, xi.regime.type.FIELDS)
end

return entity
