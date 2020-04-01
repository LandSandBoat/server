-----------------------------------
-- Area: Labyrinth of Onzozo
--  Mob: Boribaba
-----------------------------------
require("scripts/globals/regimes")
-----------------------------------

function onMobDeath(mob, player, isKiller)
    tpz.regime.checkRegime(player, mob, 776, 2, tpz.regime.type.GROUNDS)
end
