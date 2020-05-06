-----------------------------------
-- Area: Inner Horutoto Ruins
--  Mob: Battue Bats
-----------------------------------
require("scripts/globals/regimes")
-----------------------------------

function onMobDeath(mob, player, isKiller)
    tpz.regime.checkRegime(player, mob, 647, 1, tpz.regime.type.GROUNDS)
end
