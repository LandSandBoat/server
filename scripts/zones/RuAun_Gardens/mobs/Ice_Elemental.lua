-----------------------------------
-- Area: RuAun Gardens
--  Mob: Ice Elemental
-----------------------------------
require("scripts/globals/regimes")
-----------------------------------

function onMobDeath(mob, player, isKiller)
    tpz.regime.checkRegime(player, mob, 146, 1, tpz.regime.type.FIELDS)
end
