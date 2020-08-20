-----------------------------------
-- Area: Gusgen Mines
--  Mob: Madfly
-----------------------------------
require("scripts/globals/regimes")
-----------------------------------

function onMobDeath(mob, player, isKiller)
    tpz.regime.checkRegime(player, mob, 686, 2, tpz.regime.type.GROUNDS)
end
