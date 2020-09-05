-----------------------------------
-- Area: Dangruf Wadi
--  Mob: Goblin Headsman
-----------------------------------
require("scripts/globals/regimes")
-----------------------------------

function onMobDeath(mob, player, isKiller)
    tpz.regime.checkRegime(player, mob, 640, 1, tpz.regime.type.GROUNDS)
    tpz.regime.checkRegime(player, mob, 643, 2, tpz.regime.type.GROUNDS)
end
