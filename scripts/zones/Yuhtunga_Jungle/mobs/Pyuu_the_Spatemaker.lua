-----------------------------------
-- Area: Yuhtunga Jungle
--  Mob: Pyuu the Spatemaker
-----------------------------------
require("scripts/globals/hunts")
require("scripts/globals/regimes")
-----------------------------------

function onMobDeath(mob, player, isKiller)
    tpz.hunts.checkHunt(mob, player, 364)
    tpz.regime.checkRegime(player, mob, 127, 1, tpz.regime.type.FIELDS)
end
