-----------------------------------
-- Area: King Ranperres Tomb
--  Mob: Rock Eater
-----------------------------------
require("scripts/globals/regimes")
-----------------------------------

function onMobDeath(mob, player, isKiller)
    tpz.regime.checkRegime(player, mob, 634, 2, tpz.regime.type.GROUNDS)
end
