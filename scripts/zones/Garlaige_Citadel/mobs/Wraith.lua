-----------------------------------
-- Area: Garlaige Citadel
--  Mob: Wraith
-----------------------------------
require("scripts/globals/regimes")
-----------------------------------

function onMobDeath(mob, player, isKiller)
    tpz.regime.checkRegime(player, mob, 708, 3, tpz.regime.type.GROUNDS)
end
