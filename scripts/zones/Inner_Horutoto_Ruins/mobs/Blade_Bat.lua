-----------------------------------
-- Area: Inner Horutoto Ruins
--  Mob: Blade Bat
-----------------------------------
require("scripts/globals/regimes")
-----------------------------------

function onMobDeath(mob, player, isKiller)
    tpz.regime.checkRegime(player, mob, 648, 1, tpz.regime.type.GROUNDS)
end
