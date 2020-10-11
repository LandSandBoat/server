-----------------------------------
-- Area: Garlaige Citadel
--  Mob: Funnel Bats
-----------------------------------
require("scripts/globals/regimes")
-----------------------------------

function onMobDeath(mob, player, isKiller)
    tpz.regime.checkRegime(player, mob, 706, 1, tpz.regime.type.GROUNDS)
end
