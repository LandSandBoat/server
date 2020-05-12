-----------------------------------
-- Area: Outer Horutoto Ruins
--  Mob: Fuligo
-----------------------------------
require("scripts/globals/regimes")
-----------------------------------

function onMobDeath(mob, player, isKiller)
    tpz.regime.checkRegime(player, mob, 669, 2, tpz.regime.type.GROUNDS)
    tpz.regime.checkRegime(player, mob, 670, 2, tpz.regime.type.GROUNDS)
end
