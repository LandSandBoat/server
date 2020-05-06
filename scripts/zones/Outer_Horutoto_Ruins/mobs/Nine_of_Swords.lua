-----------------------------------
-- Area: Outer Horutoto Ruins
--  Mob: Nine of Swords
-----------------------------------
require("scripts/globals/regimes")
-----------------------------------

function onMobDeath(mob, player, isKiller)
    tpz.regime.checkRegime(player, mob, 668, 3, tpz.regime.type.GROUNDS)
end
