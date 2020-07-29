-----------------------------------
-- Area: Gusgen Mines
--  Mob: Rockmill
-----------------------------------
require("scripts/globals/regimes")
-----------------------------------

function onMobDeath(mob, player, isKiller)
    tpz.regime.checkRegime(player, mob, 685, 2, tpz.regime.type.GROUNDS)
end
