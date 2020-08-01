-----------------------------------
-- Area: Den of Rancor
--  Mob: Dire Bat
-----------------------------------
require("scripts/globals/regimes")
-----------------------------------

function onMobDeath(mob, player, isKiller)
    tpz.regime.checkRegime(player, mob, 796, 1, tpz.regime.type.GROUNDS)
    tpz.regime.checkRegime(player, mob, 797, 1, tpz.regime.type.GROUNDS)
end
