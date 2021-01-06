-----------------------------------
-- Area: Upper Delkfutt's Tower
--  Mob: Jotunn Wallkeeper
-----------------------------------
require("scripts/globals/regimes")
-----------------------------------
local entity = {}

function onMobDeath(mob, player, isKiller)
    tpz.regime.checkRegime(player, mob, 786, 1, tpz.regime.type.GROUNDS)
    tpz.regime.checkRegime(player, mob, 789, 2, tpz.regime.type.GROUNDS)
end

return entity
