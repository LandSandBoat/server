-----------------------------------
-- Area: Gustav Tunnel
--  Mob: Doom Guard
-----------------------------------
require("scripts/globals/regimes")
-----------------------------------

function onMobDeath(mob, player, isKiller)
    tpz.regime.checkRegime(player, mob, 765, 2, tpz.regime.type.GROUNDS)
    tpz.regime.checkRegime(player, mob, 767, 1, tpz.regime.type.GROUNDS)
    tpz.regime.checkRegime(player, mob, 768, 1, tpz.regime.type.GROUNDS)
end
