-----------------------------------
-- Area: Ordelle's Caves
--  Mob: Vorpal Bunny
-----------------------------------
require("scripts/globals/regimes")
-----------------------------------

function onMobDeath(mob, player, isKiller)
    tpz.regime.checkRegime(player, mob, 658, 2, tpz.regime.type.GROUNDS)
end
