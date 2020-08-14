-----------------------------------
-- Area: Batallia Downs
--  Mob: Sabertooth Tiger
-----------------------------------
require("scripts/globals/regimes")
-----------------------------------

function onMobDeath(mob, player, isKiller)
    tpz.regime.checkRegime(player, mob, 74, 1, tpz.regime.type.FIELDS)
    tpz.regime.checkRegime(player, mob, 75, 1, tpz.regime.type.FIELDS)
end
