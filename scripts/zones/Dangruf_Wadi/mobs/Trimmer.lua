-----------------------------------
-- Area: Dangruf Wadi
--  Mob: Trimmer
-----------------------------------
require("scripts/globals/regimes")
-----------------------------------

function onMobDeath(mob, player, isKiller)
    tpz.regime.checkRegime(player, mob, 646, 1, tpz.regime.type.GROUNDS)
end
