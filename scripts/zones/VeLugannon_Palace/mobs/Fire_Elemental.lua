-----------------------------------
-- Area: Ve'Lugannon Palace
--  Mob: Fire Elemental
-----------------------------------
require("scripts/globals/regimes")
-----------------------------------

function onMobDeath(mob, player, isKiller)
    tpz.regime.checkRegime(player, mob, 748, 1, tpz.regime.type.GROUNDS)
end
