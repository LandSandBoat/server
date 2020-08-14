-----------------------------------
-- Area: King Ranperres Tomb
--  Mob: Wind Bats
-----------------------------------
require("scripts/globals/regimes")
-----------------------------------

function onMobDeath(mob, player, isKiller)
    tpz.regime.checkRegime(player, mob, 632, 2, tpz.regime.type.GROUNDS)
end
