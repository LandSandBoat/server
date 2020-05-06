-----------------------------------
-- Area: Lower Delkfutt's Tower
--  Mob: Magic Urn
-----------------------------------
require("scripts/globals/regimes")
-----------------------------------

function onMobDeath(mob, player, isKiller)
    tpz.regime.checkRegime(player, mob, 781, 2, tpz.regime.type.GROUNDS)
end
