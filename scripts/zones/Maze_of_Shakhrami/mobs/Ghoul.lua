-----------------------------------
-- Area: Maze of Shakhrami
--  Mob: Ghoul
-----------------------------------
require("scripts/globals/regimes")
-----------------------------------

function onMobDeath(mob, player, isKiller)
    tpz.regime.checkRegime(player, mob, 697, 1, tpz.regime.type.GROUNDS)
end
