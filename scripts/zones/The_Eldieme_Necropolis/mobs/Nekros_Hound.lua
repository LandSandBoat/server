-----------------------------------
-- Area: The Eldieme Necropolis
--  Mob: Nekros Hound
-----------------------------------
require("scripts/globals/regimes")
-----------------------------------

function onMobDeath(mob, player, isKiller)
    tpz.regime.checkRegime(player, mob, 677, 2, tpz.regime.type.GROUNDS)
    tpz.regime.checkRegime(player, mob, 678, 2, tpz.regime.type.GROUNDS)
end
