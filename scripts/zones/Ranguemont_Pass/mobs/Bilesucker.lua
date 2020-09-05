-----------------------------------
-- Area: Ranguemont Pass
--  Mob: Bilesucker
-----------------------------------
require("scripts/globals/regimes")
-----------------------------------

function onMobDeath(mob, player, isKiller)
    tpz.regime.checkRegime(player, mob, 607, 1, tpz.regime.type.GROUNDS)
end
