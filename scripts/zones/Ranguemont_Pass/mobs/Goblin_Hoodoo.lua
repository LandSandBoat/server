-----------------------------------
-- Area: Ranguemont Pass
--  Mob: Goblin Hoodoo
-----------------------------------
require("scripts/globals/regimes")
-----------------------------------

function onMobDeath(mob, player, isKiller)
    tpz.regime.checkRegime(player, mob, 608, 1, tpz.regime.type.GROUNDS)
end
