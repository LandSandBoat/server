-----------------------------------
-- Area: The Boyahda Tree
--  Mob: Mourning Crawler
-----------------------------------
require("scripts/globals/regimes")
-----------------------------------

function onMobDeath(mob, player, isKiller)
    tpz.regime.checkRegime(player, mob, 726, 3, tpz.regime.type.GROUNDS)
end
