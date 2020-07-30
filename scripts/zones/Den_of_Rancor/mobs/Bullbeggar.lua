-----------------------------------
-- Area: Den of Rancor
--  Mob: Bullbeggar
-----------------------------------
require("scripts/globals/regimes")
-----------------------------------

function onMobDeath(mob, player, isKiller)
    tpz.regime.checkRegime(player, mob, 803, 2, tpz.regime.type.GROUNDS)
end
