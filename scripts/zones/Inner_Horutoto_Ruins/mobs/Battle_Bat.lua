-----------------------------------
-- Area: Inner Horutoto Ruins
--  Mob: Battle Bat
-----------------------------------
require("scripts/globals/regimes")
-----------------------------------

function onMobDeath(mob, player, isKiller)
    tpz.regime.checkRegime(player, mob, 649, 1, tpz.regime.type.GROUNDS)
end
