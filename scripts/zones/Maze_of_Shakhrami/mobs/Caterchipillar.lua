-----------------------------------
-- Area: Maze of Shakhrami
--  Mob: Caterchipillar
-----------------------------------
require("scripts/globals/regimes")
-----------------------------------
local entity = {}

entity.onMobDeath = function(mob, player, isKiller)
    tpz.regime.checkRegime(player, mob, 698, 1, tpz.regime.type.GROUNDS)
end

return entity
