-----------------------------------
-- Area: Crawlers' Nest
--  Mob: Nest Beetle
-----------------------------------
require("scripts/globals/regimes")
-----------------------------------

function onMobDeath(mob, player, isKiller)
    tpz.regime.checkRegime(player, mob, 688, 2, tpz.regime.type.GROUNDS)
end
