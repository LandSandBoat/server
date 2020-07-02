-----------------------------------
-- Area: RuAun Gardens
--  Mob: Sprinkler
-----------------------------------
require("scripts/globals/regimes")
-----------------------------------

function onMobDeath(mob, player, isKiller)
    tpz.regime.checkRegime(player, mob, 142, 2, tpz.regime.type.FIELDS)
    tpz.regime.checkRegime(player, mob, 143, 1, tpz.regime.type.FIELDS)
end


