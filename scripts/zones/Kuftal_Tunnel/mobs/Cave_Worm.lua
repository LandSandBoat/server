-----------------------------------
-- Area: Kuftal Tunnel
--  Mob: Cave Worm
-----------------------------------
require("scripts/globals/regimes")
-----------------------------------

function onMobDeath(mob, player, isKiller)
    tpz.regime.checkRegime(player, mob, 737, 1, tpz.regime.type.GROUNDS)
end
