-----------------------------------
-- Area: Quicksand Caves
--  Mob: Sand Spider
-----------------------------------
require("scripts/globals/regimes")
-----------------------------------

function onMobDeath(mob, player, isKiller)
    tpz.regime.checkRegime(player, mob, 812, 1, tpz.regime.type.GROUNDS)
end
