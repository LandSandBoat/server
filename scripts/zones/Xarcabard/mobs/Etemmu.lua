-----------------------------------
-- Area: Xarcabard
--  Mob: Etemmu
-----------------------------------
require("scripts/globals/regimes")
-----------------------------------
local entity = {}

entity.onMobDeath = function(mob, player, isKiller)
    tpz.regime.checkRegime(player, mob, 51, 2, tpz.regime.type.FIELDS)
end

return entity
