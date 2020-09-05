-----------------------------------
-- Area: Batallia Downs
--  Mob: Orcish Nightraider
-----------------------------------
require("scripts/globals/regimes")
-----------------------------------

function onMobDeath(mob, player, isKiller)
    tpz.regime.checkRegime(player, mob, 74, 3, tpz.regime.type.FIELDS)
end
