-----------------------------------
-- Area: The Eldieme Necropolis
--  Mob: Tomb Warrior
-----------------------------------
require("scripts/globals/regimes")
-----------------------------------

function onMobDeath(mob, player, isKiller)
    tpz.regime.checkRegime(player, mob, 671, 1, tpz.regime.type.GROUNDS)
    tpz.regime.checkRegime(player, mob, 675, 2, tpz.regime.type.GROUNDS)
    tpz.regime.checkRegime(player, mob, 676, 1, tpz.regime.type.GROUNDS)
end
