-----------------------------------
-- Area: Ve'Lugannon Palace
--  Mob: Mystic Weapon
-----------------------------------
require("scripts/globals/regimes")
-----------------------------------

function onMobDeath(mob, player, isKiller)
    tpz.regime.checkRegime(player, mob, 743, 1, tpz.regime.type.GROUNDS)
    tpz.regime.checkRegime(player, mob, 744, 1, tpz.regime.type.GROUNDS)
end
