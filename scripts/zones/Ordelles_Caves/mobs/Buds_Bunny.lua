-----------------------------------
-- Area: Ordelle's Caves
--  Mob: Buds Bunny
-----------------------------------
require("scripts/globals/regimes")
-----------------------------------

function onMobDeath(mob, player, isKiller)
    tpz.regime.checkRegime(player, mob, 661, 1, tpz.regime.type.GROUNDS)
end
