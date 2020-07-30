-----------------------------------
-- Area: Dangruf Wadi
--  Mob: Natty Gibbon
-----------------------------------
require("scripts/globals/regimes")
-----------------------------------

function onMobDeath(mob, player, isKiller)
    tpz.regime.checkRegime(player, mob, 646, 2, tpz.regime.type.GROUNDS)
end
