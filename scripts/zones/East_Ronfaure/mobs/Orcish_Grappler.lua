-----------------------------------
-- Area: East Ronfaure
--  Mob: Orcish Grappler
-----------------------------------
require("scripts/globals/regimes")
-----------------------------------

function onMobDeath(mob, player, isKiller)
    tpz.regime.checkRegime(player, mob, 67, 1, tpz.regime.type.FIELDS)
end
