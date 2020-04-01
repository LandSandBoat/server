-----------------------------------
-- Area: Kuftal Tunnel
--  Mob: Machairodus
-----------------------------------
require("scripts/globals/regimes")
-----------------------------------

function onMobDeath(mob, player, isKiller)
    tpz.regime.checkRegime(player, mob, 742, 2, tpz.regime.type.GROUNDS)
end
