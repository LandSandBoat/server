-----------------------------------
-- Area: Ordelle's Caves
--  Mob: Stroper
-----------------------------------
require("scripts/globals/regimes")
-----------------------------------

function onMobDeath(mob, player, isKiller)
    tpz.regime.checkRegime(player, mob, 660, 2, tpz.regime.type.GROUNDS)
end
