-----------------------------------
-- Area: Garlaige Citadel
--  Mob: Warden Beetle
-----------------------------------
require("scripts/globals/regimes")
-----------------------------------

function onMobDeath(mob, player, isKiller)
    tpz.regime.checkRegime(player, mob, 710, 2, tpz.regime.type.GROUNDS)
end
