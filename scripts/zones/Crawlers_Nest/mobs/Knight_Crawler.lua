-----------------------------------
-- Area: Crawlers' Nest
--  Mob: Knight Crawler
-----------------------------------
require("scripts/globals/regimes")
-----------------------------------

function onMobDeath(mob, player, isKiller)
    tpz.regime.checkRegime(player, mob, 692, 2, tpz.regime.type.GROUNDS)
end
