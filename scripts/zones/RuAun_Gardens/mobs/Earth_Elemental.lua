-----------------------------------
-- Area: RuAun Gardens
--  Mob: Earth Elemental
-----------------------------------
require("scripts/globals/regimes")
-----------------------------------

function onMobDeath(mob, player, isKiller)
    tpz.regime.checkRegime(player, mob, 146, 2, tpz.regime.type.FIELDS)
end
