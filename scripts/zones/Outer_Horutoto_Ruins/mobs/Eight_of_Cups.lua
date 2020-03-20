-----------------------------------
-- Area: Outer Horutoto Ruins
--  Mob: Eight of Cups
-----------------------------------
require("scripts/globals/regimes")
-----------------------------------

function onMobDeath(mob, player, isKiller)
    tpz.regime.checkRegime(player, mob, 667, 1, tpz.regime.type.GROUNDS)
end
