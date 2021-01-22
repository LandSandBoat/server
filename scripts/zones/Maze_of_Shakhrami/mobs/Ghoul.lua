-----------------------------------
-- Area: Maze of Shakhrami
--  Mob: Ghoul
-----------------------------------
require("scripts/globals/regimes")
-----------------------------------
local entity = {}

entity.onMobDeath = function(mob, player, isKiller)
    tpz.regime.checkRegime(player, mob, 697, 1, tpz.regime.type.GROUNDS)
end

return entity
