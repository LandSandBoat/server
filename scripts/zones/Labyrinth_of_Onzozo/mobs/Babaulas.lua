-----------------------------------
-- Area: Labyrinth of Onzozo
--  Mob: Babaulas
-----------------------------------
require("scripts/globals/regimes")
-----------------------------------

function onMobDeath(mob, player, isKiller)
    tpz.regime.checkRegime(player, mob, 776, 1, tpz.regime.type.GROUNDS)
end
