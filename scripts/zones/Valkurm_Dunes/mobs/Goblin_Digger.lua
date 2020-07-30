-----------------------------------
-- Area: Valkurm Dunes
--  Mob: Goblin Digger
-----------------------------------
require("scripts/globals/regimes")
-----------------------------------

function onMobDeath(mob, player, isKiller)
    tpz.regime.checkRegime(player, mob, 57, 2, tpz.regime.type.FIELDS)
end
