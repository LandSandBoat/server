-----------------------------------
-- Area: Gustav Tunnel
--  Mob: Demonic Pugil
-----------------------------------
require("scripts/globals/regimes")
-----------------------------------

function onMobDeath(mob, player, isKiller)
    tpz.regime.checkRegime(player, mob, 766, 2, tpz.regime.type.GROUNDS)
end
