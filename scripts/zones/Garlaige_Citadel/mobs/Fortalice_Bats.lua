-----------------------------------
-- Area: Garlaige Citadel
--  Mob: Fortalice Bats
-----------------------------------
require("scripts/globals/regimes")
-----------------------------------

function onMobDeath(mob, player, isKiller)
    tpz.regime.checkRegime(player, mob, 710, 1, tpz.regime.type.GROUNDS)
end
