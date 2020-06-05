-----------------------------------
-- Area: Kuftal Tunnel
--  Mob: Kuftal Delver
-----------------------------------
require("scripts/globals/regimes")
-----------------------------------

function onMobDeath(mob, player, isKiller)
    tpz.regime.checkRegime(player, mob, 742, 1, tpz.regime.type.GROUNDS)
end
