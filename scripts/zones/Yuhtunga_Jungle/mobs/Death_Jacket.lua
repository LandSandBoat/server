-----------------------------------
-- Area: Yuhtunga Jungle
--  Mob: Death Jacket
-----------------------------------
require("scripts/globals/regimes")
-----------------------------------

function onMobDeath(mob, player, isKiller)
    tpz.regime.checkRegime(player, mob, 125, 1, tpz.regime.type.FIELDS)
end
