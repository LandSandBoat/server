-----------------------------------
-- Area: Outer Horutoto Ruins
--  Mob: Six of Batons
-----------------------------------
require("scripts/globals/regimes")
-----------------------------------

function onMobDeath(mob, player, isKiller)
    tpz.regime.checkRegime(player, mob, 665, 2, tpz.regime.type.GROUNDS)
end
