-----------------------------------
-- Area: Dangruf Wadi
--  Mob: Wadi Crab
-----------------------------------
require("scripts/globals/regimes")
-----------------------------------

function onMobDeath(mob, player, isKiller)
    tpz.regime.checkRegime(player, mob, 640, 2, tpz.regime.type.GROUNDS)
end
