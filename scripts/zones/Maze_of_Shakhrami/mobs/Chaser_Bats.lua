-----------------------------------
-- Area: Maze of Shakhrami
--  Mob: Chaser Bats
-----------------------------------
require("scripts/globals/regimes")
-----------------------------------
local entity = {}

entity.onMobDeath = function(mob, player, isKiller)
    xi.regime.checkRegime(player, mob, 701, 1, xi.regime.type.GROUNDS)
end

return entity
