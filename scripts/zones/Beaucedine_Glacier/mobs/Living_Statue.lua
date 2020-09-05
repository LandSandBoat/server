-----------------------------------
-- Area: Beaucedine Glacier
--  Mob: Living Statue
-----------------------------------
require("scripts/globals/regimes")
-----------------------------------

function onMobDeath(mob, player, isKiller)
    tpz.regime.checkRegime(player, mob, 47, 2, tpz.regime.type.FIELDS)
    tpz.regime.checkRegime(player, mob, 48, 2, tpz.regime.type.FIELDS)
    tpz.regime.checkRegime(player, mob, 49, 3, tpz.regime.type.FIELDS)
end
