-----------------------------------
-- Area: Behemoths Dominion
--  Mob: Greater Gayla
-----------------------------------
require("scripts/globals/regimes")
-----------------------------------

function onMobDeath(mob, player, isKiller)
    tpz.regime.checkRegime(player, mob, 101, 2, tpz.regime.type.FIELDS)
    tpz.regime.checkRegime(player, mob, 103, 1, tpz.regime.type.FIELDS)
end
