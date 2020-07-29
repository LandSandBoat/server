-----------------------------------
-- Area: The Eldieme Necropolis
--  Mob: Azer
-----------------------------------
require("scripts/globals/regimes")
-----------------------------------

function onMobDeath(mob, player, isKiller)
    tpz.regime.checkRegime(player, mob, 673, 2, tpz.regime.type.GROUNDS)
end
