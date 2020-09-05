-----------------------------------
-- Area: Quicksand Caves
--  Mob: Antican Antesignanus
-----------------------------------
require("scripts/globals/regimes")
-----------------------------------

function onMobDeath(mob, player, isKiller)
    tpz.regime.checkRegime(player, mob, 812, 2, tpz.regime.type.GROUNDS)
    tpz.regime.checkRegime(player, mob, 813, 2, tpz.regime.type.GROUNDS)
    tpz.regime.checkRegime(player, mob, 814, 2, tpz.regime.type.GROUNDS)
    tpz.regime.checkRegime(player, mob, 815, 1, tpz.regime.type.GROUNDS)
    tpz.regime.checkRegime(player, mob, 816, 2, tpz.regime.type.GROUNDS)
    tpz.regime.checkRegime(player, mob, 817, 2, tpz.regime.type.GROUNDS)
    tpz.regime.checkRegime(player, mob, 818, 2, tpz.regime.type.GROUNDS)
    tpz.regime.checkRegime(player, mob, 819, 2, tpz.regime.type.GROUNDS)
end
