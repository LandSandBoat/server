-----------------------------------
-- Area: Middle Delkfutt's Tower
--  Mob: Goblin Pathfinder
-----------------------------------
require("scripts/globals/regimes")
-----------------------------------
local entity = {}

function onMobDeath(mob, player, isKiller)
    tpz.regime.checkRegime(player, mob, 782, 1, tpz.regime.type.GROUNDS)
    tpz.regime.checkRegime(player, mob, 784, 1, tpz.regime.type.GROUNDS)
end

return entity
