-----------------------------------
-- Area: Inner Horutoto Ruins
--  Mob: Goblin Trailblazer
-----------------------------------
require("scripts/globals/regimes")
-----------------------------------

function onMobDeath(mob, player, isKiller)
    tpz.regime.checkRegime(player, mob, 651, 2, tpz.regime.type.GROUNDS)
end
