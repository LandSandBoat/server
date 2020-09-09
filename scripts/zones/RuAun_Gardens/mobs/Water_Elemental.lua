-----------------------------------
-- Area: RuAun Gardens
--  Mob: Water Elemental
-----------------------------------
require("scripts/globals/regimes")
-----------------------------------

function onMobDeath(mob, player, isKiller)
    tpz.regime.checkRegime(player, mob, 146, 3, tpz.regime.type.FIELDS)
end
