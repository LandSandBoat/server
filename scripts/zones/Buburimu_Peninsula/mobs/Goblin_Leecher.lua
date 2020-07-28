-----------------------------------
-- Area: Buburimu Peninsula
--  Mob: Goblin Leecher
-----------------------------------
require("scripts/globals/regimes")
-----------------------------------

function onMobDeath(mob, player, isKiller)
    tpz.regime.checkRegime(player, mob, 62, 2, tpz.regime.type.FIELDS)
end
