-----------------------------------
-- Area: RuAun Gardens
--  Mob: Air Elemental
-----------------------------------
require("scripts/globals/regimes")
-----------------------------------

function onMobDeath(mob, player, isKiller)
    tpz.regime.checkRegime(player, mob, 145, 2, tpz.regime.type.FIELDS)
end
