-----------------------------------
-- Area: Batallia Downs
--  Mob: May Fly
-----------------------------------
require("scripts/globals/regimes")
-----------------------------------

function onMobDeath(mob, player, isKiller)
    tpz.regime.checkRegime(player, mob, 15, 1, tpz.regime.type.FIELDS)
    tpz.regime.checkRegime(player, mob, 72, 2, tpz.regime.type.FIELDS)
end
