-----------------------------------
-- Area: Yuhtunga Jungle
--   NM: Mischievous Micholas
-----------------------------------
require("scripts/globals/hunts")
require("scripts/globals/regimes")
-----------------------------------

function onMobDeath(mob, player, isKiller)
    tpz.hunts.checkHunt(mob, player, isKiller)
    tpz.regime.checkRegime(player, mob, 126, 1, tpz.regime.type.FIELDS)
    tpz.regime.checkRegime(player, mob, 128, 1, tpz.regime.type.FIELDS)
end
