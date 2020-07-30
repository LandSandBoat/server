-----------------------------------
-- Area: Garlaige Citadel
--  Mob: Chamber Beetle
-----------------------------------
require("scripts/globals/regimes")
-----------------------------------

function onMobDeath(mob, player, isKiller)
    tpz.regime.checkRegime(player, mob, 707, 2, tpz.regime.type.GROUNDS)
end
