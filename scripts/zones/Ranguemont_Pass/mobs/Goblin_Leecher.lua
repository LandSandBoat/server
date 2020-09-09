-----------------------------------
-- Area: Ranguemont Pass
--  Mob: Goblin Leecher
-----------------------------------
require("scripts/globals/regimes")
-----------------------------------

function onMobDeath(mob, player, isKiller)
    tpz.regime.checkRegime(player, mob, 605, 1, tpz.regime.type.GROUNDS)
end
