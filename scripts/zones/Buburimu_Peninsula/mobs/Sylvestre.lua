-----------------------------------
-- Area: Buburimu Peninsula
--  Mob: Sylvestre
-----------------------------------
require("scripts/globals/regimes")
-----------------------------------

function onMobDeath(mob, player, isKiller)
    tpz.regime.checkRegime(player, mob, 32, 1, tpz.regime.type.FIELDS)
    tpz.regime.checkRegime(player, mob, 33, 2, tpz.regime.type.FIELDS)
end
