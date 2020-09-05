-----------------------------------
-- Area: Quicksand Caves
--  Mob: Sand Eater
-----------------------------------
require("scripts/globals/regimes")
-----------------------------------

function onMobDeath(mob, player, isKiller)
    tpz.regime.checkRegime(player, mob, 814, 1, tpz.regime.type.GROUNDS)
end
