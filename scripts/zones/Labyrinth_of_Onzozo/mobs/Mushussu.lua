-----------------------------------
-- Area: Labyrinth of Onzozo
--  Mob: Mushussu
-----------------------------------
require("scripts/globals/regimes")
-----------------------------------

function onMobDeath(mob, player, isKiller)
    tpz.regime.checkRegime(player, mob, 773, 1, tpz.regime.type.GROUNDS)
end
