-----------------------------------
-- Area: Korroloka Tunnel
--  Mob: Combat
-----------------------------------
require("scripts/globals/regimes")
-----------------------------------

function onMobDeath(mob, player, isKiller)
    tpz.regime.checkRegime(player, mob, 728, 2, tpz.regime.type.GROUNDS)
end
