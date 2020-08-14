-----------------------------------
-- Area: Den of Rancor
--  Mob: Cave Worm
-----------------------------------
require("scripts/globals/regimes")
-----------------------------------

function onMobDeath(mob, player, isKiller)
    tpz.regime.checkRegime(player, mob, 796, 2, tpz.regime.type.GROUNDS)
end
