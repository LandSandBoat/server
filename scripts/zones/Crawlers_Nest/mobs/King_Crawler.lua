-----------------------------------
-- Area: Crawlers' Nest
--  Mob: King Crawler
-----------------------------------
require("scripts/globals/regimes")
-----------------------------------

function onMobDeath(mob, player, isKiller)
    tpz.regime.checkRegime(player, mob, 693, 1, tpz.regime.type.GROUNDS)
end
