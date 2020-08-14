-----------------------------------
-- Area: Gusgen Mines
--  Mob: Amphisbaena
-----------------------------------
require("scripts/globals/regimes")
-----------------------------------

function onMobDeath(mob, player, isKiller)
    tpz.regime.checkRegime(player, mob, 682, 2, tpz.regime.type.GROUNDS)
end
