-----------------------------------
-- Area: Ordelle's Caves
--  Mob: Ancient Bat
-----------------------------------
require("scripts/globals/regimes")
-----------------------------------

function onMobDeath(mob, player, isKiller)
    tpz.regime.checkRegime(player, mob, 659, 1, tpz.regime.type.GROUNDS)
end
