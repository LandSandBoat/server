-----------------------------------
-- Area: King Ranperres Tomb
--  Mob: Plague Bats
-----------------------------------
require("scripts/globals/regimes")
-----------------------------------

function onMobDeath(mob, player, isKiller)
    tpz.regime.checkRegime(player, mob, 634, 1, tpz.regime.type.GROUNDS)
end
