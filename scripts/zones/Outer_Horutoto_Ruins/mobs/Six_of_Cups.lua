-----------------------------------
-- Area: Outer Horutoto Ruins
--  Mob: Six of Cups
-----------------------------------
require("scripts/globals/regimes")
-----------------------------------

function onMobDeath(mob, player, isKiller)
    tpz.regime.checkRegime(player, mob, 665, 1, tpz.regime.type.GROUNDS)
end
