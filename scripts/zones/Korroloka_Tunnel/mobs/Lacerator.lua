-----------------------------------
-- Area: Korroloka Tunnel
--  Mob: Lacerator
-----------------------------------
require("scripts/globals/regimes")
-----------------------------------

function onMobDeath(mob, player, isKiller)
    tpz.regime.checkRegime(player, mob, 734, 1, tpz.regime.type.GROUNDS)
end
