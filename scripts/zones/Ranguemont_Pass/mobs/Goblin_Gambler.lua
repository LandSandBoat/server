-----------------------------------
-- Area: Ranguemont Pass
--  Mob: Goblin Gambler
-----------------------------------
require("scripts/globals/regimes")
-----------------------------------

function onMobDeath(mob, player, isKiller)
    tpz.regime.checkRegime(player, mob, 604, 2, tpz.regime.type.GROUNDS)
    tpz.regime.checkRegime(player, mob, 605, 2, tpz.regime.type.GROUNDS)
end
