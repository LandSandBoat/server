-----------------------------------
-- Area: Crawlers' Nest
--  Mob: Labyrinth Lizard
-----------------------------------
require("scripts/globals/regimes")
-----------------------------------

function onMobDeath(mob, player, isKiller)
    tpz.regime.checkRegime(player, mob, 689, 1, tpz.regime.type.GROUNDS)
end
