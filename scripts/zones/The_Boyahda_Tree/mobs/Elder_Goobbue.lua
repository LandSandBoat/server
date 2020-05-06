-----------------------------------
-- Area: The Boyahda Tree
--  Mob: Elder Goobbue
-----------------------------------
require("scripts/globals/regimes")
-----------------------------------

function onMobDeath(mob, player, isKiller)
    tpz.regime.checkRegime(player, mob, 722, 2, tpz.regime.type.GROUNDS)
end
