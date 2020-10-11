-----------------------------------
-- Area: Batallia Downs
--  Mob: Ba
-----------------------------------
require("scripts/globals/regimes")
-----------------------------------

function onMobDeath(mob, player, isKiller)
    tpz.regime.checkRegime(player, mob, 15, 2, tpz.regime.type.FIELDS)
    tpz.regime.checkRegime(player, mob, 73, 2, tpz.regime.type.FIELDS)
end
