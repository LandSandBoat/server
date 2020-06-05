-----------------------------------
-- Area: Maze of Shakhrami
--  Mob: Crypterpillar
-----------------------------------
require("scripts/globals/regimes")
-----------------------------------

function onMobDeath(mob, player, isKiller)
    tpz.regime.checkRegime(player, mob, 702, 2, tpz.regime.type.GROUNDS)
end
