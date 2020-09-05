-----------------------------------
-- Area: Quicksand Caves
--  Mob: Girtab
-----------------------------------
require("scripts/globals/regimes")
-----------------------------------

function onMobDeath(mob, player, isKiller)
    tpz.regime.checkRegime(player, mob, 818, 1, tpz.regime.type.GROUNDS)
end
