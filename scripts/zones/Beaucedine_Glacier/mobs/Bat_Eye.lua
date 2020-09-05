-----------------------------------
-- Area: Beaucedine Glacier
--  Mob: Bat Eye
-----------------------------------
require("scripts/globals/regimes")
-----------------------------------

function onMobDeath(mob, player, isKiller)
    tpz.regime.checkRegime(player, mob, 48, 1, tpz.regime.type.FIELDS)
    tpz.regime.checkRegime(player, mob, 49, 2, tpz.regime.type.FIELDS)
    tpz.regime.checkRegime(player, mob, 50, 3, tpz.regime.type.FIELDS)
end
