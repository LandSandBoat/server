-----------------------------------
-- Area: Valkurm Dunes
--  Mob: Snipper
-----------------------------------
require("scripts/globals/regimes")
-----------------------------------

function onMobDeath(mob, player, isKiller)
    tpz.regime.checkRegime(player, mob, 8, 1, tpz.regime.type.FIELDS)
    tpz.regime.checkRegime(player, mob, 9, 2, tpz.regime.type.FIELDS)
end
