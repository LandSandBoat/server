-----------------------------------
-- Area: Fei'Yin
--  Mob: Wekufe
-----------------------------------
require("scripts/globals/regimes")
-----------------------------------

function onMobDeath(mob, player, isKiller)
    tpz.regime.checkRegime(player, mob, 717, 2, tpz.regime.type.GROUNDS)
end
