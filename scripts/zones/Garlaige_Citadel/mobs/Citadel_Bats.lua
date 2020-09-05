-----------------------------------
-- Area: Garlaige Citadel
--  Mob: Citadel Bats
-----------------------------------
require("scripts/globals/regimes")
-----------------------------------

function onMobDeath(mob, player, isKiller)
    tpz.regime.checkRegime(player, mob, 705, 2, tpz.regime.type.GROUNDS)
end
