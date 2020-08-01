-----------------------------------
-- Area: Gusgen Mines
--  Mob: Greater Pugil
-----------------------------------
require("scripts/globals/regimes")
-----------------------------------

function onMobDeath(mob, player, isKiller)
    tpz.regime.checkRegime(player, mob, 682, 1, tpz.regime.type.GROUNDS)
end
