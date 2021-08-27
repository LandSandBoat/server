-----------------------------------
-- Area: Maze of Shakhrami
--  Mob: Warren Bat
-----------------------------------
require("scripts/globals/regimes")
-----------------------------------
local entity = {}

entity.onMobDeath = function(mob, player, isKiller)
    xi.regime.checkRegime(player, mob, 702, 1, xi.regime.type.GROUNDS)
end

return entity
