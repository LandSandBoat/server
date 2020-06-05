-----------------------------------
-- Area: Lower Delkfutt's Tower
--  Mob: Chaos Idol
-----------------------------------
require("scripts/globals/regimes")
-----------------------------------

function onMobDeath(mob, player, isKiller)
    tpz.regime.checkRegime(player, mob, 779, 2, tpz.regime.type.GROUNDS)
end
