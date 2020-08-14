-----------------------------------
-- Area: RuAun Gardens
--  Mob: Eraser (Monster)
-----------------------------------
require("scripts/globals/regimes")
-----------------------------------

function onMobDeath(mob, player, isKiller)
    tpz.regime.checkRegime(player, mob, 143, 2, tpz.regime.type.FIELDS)
    tpz.regime.checkRegime(player, mob, 144, 1, tpz.regime.type.FIELDS)
end
