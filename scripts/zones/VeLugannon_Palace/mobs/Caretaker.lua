-----------------------------------
-- Area: Ve'Lugannon Palace
--  Mob: Caretaker
-----------------------------------
require("scripts/globals/regimes")
-----------------------------------

function onMobDeath(mob, player, isKiller)
    tpz.regime.checkRegime(player, mob, 743, 1, tpz.regime.type.GROUNDS)
    tpz.regime.checkRegime(player, mob, 746, 1, tpz.regime.type.GROUNDS)
end
