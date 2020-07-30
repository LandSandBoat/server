-----------------------------------
-- Area: Gustav Tunnel
--  Mob: Goblin Shepherd
-----------------------------------
require("scripts/globals/regimes")
-----------------------------------

function onMobDeath(mob, player, isKiller)
    tpz.regime.checkRegime(player, mob, 764, 3, tpz.regime.type.GROUNDS)
    tpz.regime.checkRegime(player, mob, 765, 3, tpz.regime.type.GROUNDS)
end
