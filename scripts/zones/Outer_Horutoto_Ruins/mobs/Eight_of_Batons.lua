-----------------------------------
-- Area: Outer Horutoto Ruins
--  Mob: Eight of Batons
-----------------------------------
require("scripts/globals/regimes")
-----------------------------------

function onMobDeath(mob, player, isKiller)
    tpz.regime.checkRegime(player, mob, 667, 2, tpz.regime.type.GROUNDS)
end
