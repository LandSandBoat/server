-----------------------------------
-- Area: Dangruf Wadi
--  Mob: Fume Lizard
-----------------------------------
require("scripts/globals/regimes")
-----------------------------------

function onMobDeath(mob, player, isKiller)
    tpz.regime.checkRegime(player, mob, 642, 1, tpz.regime.type.GROUNDS)
end
