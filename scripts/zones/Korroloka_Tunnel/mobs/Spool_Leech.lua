-----------------------------------
-- Area: Korroloka Tunnel
--  Mob: Spool Leech
-----------------------------------
require("scripts/globals/regimes")
-----------------------------------

function onMobDeath(mob, player, isKiller)
    tpz.regime.checkRegime(player, mob, 734, 2, tpz.regime.type.GROUNDS)
end
