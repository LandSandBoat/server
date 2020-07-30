-----------------------------------
-- Area: Gusgen Mines
--  Mob: Ghast
-----------------------------------
require("scripts/globals/regimes")
-----------------------------------

function onMobDeath(mob, player, isKiller)
    tpz.regime.checkRegime(player, mob, 679, 1, tpz.regime.type.GROUNDS)
    tpz.regime.checkRegime(player, mob, 680, 2, tpz.regime.type.GROUNDS)
    tpz.regime.checkRegime(player, mob, 684, 1, tpz.regime.type.GROUNDS)
end
