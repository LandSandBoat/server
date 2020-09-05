-----------------------------------
-- Area: Quicksand Caves
--  Mob: Sand Tarantula
-----------------------------------
require("scripts/globals/regimes")
-----------------------------------

function onMobDeath(mob, player, isKiller)
    tpz.regime.checkRegime(player, mob, 819, 1, tpz.regime.type.GROUNDS)
end
