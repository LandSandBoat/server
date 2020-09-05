-----------------------------------
-- Area: Gusgen Mines
--  Mob: Wight
-----------------------------------
require("scripts/globals/regimes")
-----------------------------------

function onMobDeath(mob, player, isKiller)
    tpz.regime.checkRegime(player, mob, 679, 1, tpz.regime.type.GROUNDS)
    tpz.regime.checkRegime(player, mob, 680, 2, tpz.regime.type.GROUNDS)
    tpz.regime.checkRegime(player, mob, 683, 1, tpz.regime.type.GROUNDS)
end
