-----------------------------------
-- Area: Maze of Shakhrami
--  Mob: Abyss Worm
-----------------------------------
require("scripts/globals/regimes")
-----------------------------------
local entity = {}

function onMobDeath(mob, player, isKiller)
    tpz.regime.checkRegime(player, mob, 699, 1, tpz.regime.type.GROUNDS)
    tpz.regime.checkRegime(player, mob, 700, 1, tpz.regime.type.GROUNDS)
end

return entity
