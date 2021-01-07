-----------------------------------
-- Area: Lower Delkfutt's Tower
--  Mob: Gigas Hallwatcher
-----------------------------------
require("scripts/globals/regimes")
-----------------------------------
local entity = {}

function onMobDeath(mob, player, isKiller)
    tpz.regime.checkRegime(player, mob, 778, 2, tpz.regime.type.GROUNDS)
end

return entity
