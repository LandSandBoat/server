-----------------------------------
-- Area: Maze of Shakhrami
--  Mob: Ancient Bat
-----------------------------------
require("scripts/globals/regimes")
-----------------------------------
local entity = {}

function onMobDeath(mob, player, isKiller)
    tpz.regime.checkRegime(player, mob, 698, 2, tpz.regime.type.GROUNDS)
    tpz.regime.checkRegime(player, mob, 699, 2, tpz.regime.type.GROUNDS)
end

return entity
