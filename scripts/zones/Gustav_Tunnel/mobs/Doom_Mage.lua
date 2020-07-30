-----------------------------------
-- Area: Gustav Tunnel
--  Mob: Doom Mage
-----------------------------------
require("scripts/globals/regimes")
-----------------------------------

function onMobDeath(mob, player, isKiller)
    tpz.regime.checkRegime(player, mob, 765, 2, tpz.regime.type.GROUNDS)
end
