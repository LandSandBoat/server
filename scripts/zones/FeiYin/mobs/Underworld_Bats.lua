-----------------------------------
-- Area: Fei'Yin
--  Mob: Underworld Bats
-----------------------------------
require("scripts/globals/regimes")
-----------------------------------

function onMobDeath(mob, player, isKiller)
    tpz.regime.checkRegime(player, mob, 713, 1, tpz.regime.type.GROUNDS)
    tpz.regime.checkRegime(player, mob, 714, 1, tpz.regime.type.GROUNDS)
    tpz.regime.checkRegime(player, mob, 715, 1, tpz.regime.type.GROUNDS)
end
