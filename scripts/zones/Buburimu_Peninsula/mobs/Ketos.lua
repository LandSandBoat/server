-----------------------------------
-- Area: Buburimu Peninsula
--  Mob: Ketos
-----------------------------------
require("scripts/globals/regimes")
-----------------------------------

function onMobDeath(mob, player, isKiller)
    tpz.regime.checkRegime(player, mob, 62, 1, tpz.regime.type.FIELDS)
end
