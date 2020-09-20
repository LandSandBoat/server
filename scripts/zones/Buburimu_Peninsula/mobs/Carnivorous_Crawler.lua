-----------------------------------
-- Area: Buburimu Peninsula
--  Mob: Carnivorous Crawler
-----------------------------------
require("scripts/globals/regimes")
-----------------------------------

function onMobDeath(mob, player, isKiller)
    tpz.regime.checkRegime(player, mob, 33, 1, tpz.regime.type.FIELDS)
    tpz.regime.checkRegime(player, mob, 34, 2, tpz.regime.type.FIELDS)
end
