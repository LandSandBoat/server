-----------------------------------
-- Area: Outer Horutoto Ruins
--  Mob: Seven of Cups
-----------------------------------
require("scripts/globals/regimes")
-----------------------------------

function onMobDeath(mob, player, isKiller)
    tpz.regime.checkRegime(player, mob, 666, 1, tpz.regime.type.GROUNDS)
end
