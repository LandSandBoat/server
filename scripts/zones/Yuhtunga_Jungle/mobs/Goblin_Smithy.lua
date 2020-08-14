-----------------------------------
-- Area: Yuhtunga Jungle
--  Mob: Goblin Smithy
-----------------------------------
require("scripts/globals/regimes")
-----------------------------------

function onMobDeath(mob, player, isKiller)
    tpz.regime.checkRegime(player, mob, 125, 2, tpz.regime.type.FIELDS)
end
