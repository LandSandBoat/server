-----------------------------------
-- Area: Ordelle's Caves
--  Mob: Goblin Tinkerer
-----------------------------------
require("scripts/globals/regimes")
-----------------------------------

function onMobDeath(mob, player, isKiller)
    tpz.regime.checkRegime(player, mob, 657, 1, tpz.regime.type.GROUNDS)
end
