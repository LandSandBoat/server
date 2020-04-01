-----------------------------------
-- Area: Maze of Shakhrami
--  Mob: Chaser Bats
-----------------------------------
require("scripts/globals/regimes")
-----------------------------------

function onMobDeath(mob, player, isKiller)
    tpz.regime.checkRegime(player, mob, 701, 1, tpz.regime.type.GROUNDS)
end
