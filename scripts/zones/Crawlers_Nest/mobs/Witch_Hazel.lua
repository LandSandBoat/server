-----------------------------------
-- Area: Crawlers' Nest
--  Mob: Witch Hazel
-----------------------------------
require("scripts/globals/regimes")
-----------------------------------

function onMobDeath(mob, player, isKiller)
    tpz.regime.checkRegime(player, mob, 689, 2, tpz.regime.type.GROUNDS)
end
