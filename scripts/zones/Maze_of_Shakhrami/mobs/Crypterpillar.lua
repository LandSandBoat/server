-----------------------------------
-- Area: Maze of Shakhrami
--  Mob: Crypterpillar
-----------------------------------
require("scripts/globals/regimes")
-----------------------------------
local entity = {}

entity.onMobDeath = function(mob, player, isKiller)
    xi.regime.checkRegime(player, mob, 702, 2, xi.regime.type.GROUNDS)
end

return entity
