-----------------------------------
-- Area: Crawlers' Nest
--  Mob: Hornfly
-----------------------------------
require("scripts/globals/regimes")
-----------------------------------

function onMobDeath(mob, player, isKiller)
    tpz.regime.checkRegime(player, mob, 690, 2, tpz.regime.type.GROUNDS)
end
