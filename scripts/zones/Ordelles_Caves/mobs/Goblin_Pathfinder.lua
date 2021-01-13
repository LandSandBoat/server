-----------------------------------
-- Area: Ordelle's Caves
--  Mob: Goblin Pathfinder
-----------------------------------
require("scripts/globals/regimes")
-----------------------------------
local entity = {}

entity.onMobDeath = function(mob, player, isKiller)
    tpz.regime.checkRegime(player, mob, 657, 1, tpz.regime.type.GROUNDS)
end

return entity
