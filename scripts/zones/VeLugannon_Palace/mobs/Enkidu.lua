-----------------------------------
-- Area: Ve'Lugannon Palace
--  Mob: Enkidu
-----------------------------------
require("scripts/globals/regimes")
-----------------------------------

function onMobDeath(mob, player, isKiller)
    tpz.regime.checkRegime(player, mob, 743, 1, tpz.regime.type.GROUNDS)
    tpz.regime.checkRegime(player, mob, 747, 1, tpz.regime.type.GROUNDS)
end
