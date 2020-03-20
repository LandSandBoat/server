-----------------------------------
-- Area: Inner Horutoto Ruins
--  Mob: Goblin Flesher
-----------------------------------
require("scripts/globals/regimes")
-----------------------------------

function onMobDeath(mob, player, isKiller)
    tpz.regime.checkRegime(player, mob, 652, 2, tpz.regime.type.GROUNDS)
end
