-----------------------------------
-- Area: Outer Horutoto Ruins
--  Mob: Seven of Batons
-----------------------------------
require("scripts/globals/regimes")
-----------------------------------

function onMobDeath(mob, player, isKiller)
    tpz.regime.checkRegime(player, mob, 666, 2, tpz.regime.type.GROUNDS)
end
