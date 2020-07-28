-----------------------------------
-- Area: Dangruf Wadi
--  Mob: Rock Lizard
-----------------------------------
require("scripts/globals/regimes")
-----------------------------------

function onMobDeath(mob, player, isKiller)
    tpz.regime.checkRegime(player, mob, 639, 2, tpz.regime.type.GROUNDS)
end
