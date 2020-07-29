-----------------------------------
-- Area: RuAun Gardens
--  Mob: Thunder Elemental
-----------------------------------
require("scripts/globals/regimes")
-----------------------------------

function onMobDeath(mob, player, isKiller)
    tpz.regime.checkRegime(player, mob, 145, 3, tpz.regime.type.FIELDS)
end
