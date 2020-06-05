-----------------------------------
-- Area: Inner Horutoto Ruins
--  Mob: Blob
-----------------------------------
require("scripts/globals/regimes")
-----------------------------------

function onMobDeath(mob, player, isKiller)
    tpz.regime.checkRegime(player, mob, 649, 2, tpz.regime.type.GROUNDS)
end
