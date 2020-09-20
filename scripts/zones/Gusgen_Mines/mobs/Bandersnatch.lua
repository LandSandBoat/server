-----------------------------------
-- Area: Gusgen Mines
--  Mob: Bandersnatch
-----------------------------------
require("scripts/globals/regimes")
-----------------------------------

function onMobDeath(mob, player, isKiller)
    tpz.regime.checkRegime(player, mob, 681, 2, tpz.regime.type.GROUNDS)
end
