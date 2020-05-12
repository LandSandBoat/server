-----------------------------------
-- Area: Lower Delkfutt's Tower
--  Mob: Gigas Hallwatcher
-----------------------------------
require("scripts/globals/regimes")
-----------------------------------

function onMobDeath(mob, player, isKiller)
    tpz.regime.checkRegime(player, mob, 778, 2, tpz.regime.type.GROUNDS)
end
