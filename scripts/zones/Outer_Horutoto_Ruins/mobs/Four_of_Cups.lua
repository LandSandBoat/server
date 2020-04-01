-----------------------------------
-- Area: Outer Horutoto Ruins
--  Mob: Four of Cups
-----------------------------------
require("scripts/globals/regimes")
-----------------------------------

function onMobDeath(mob, player, isKiller)
    tpz.regime.checkRegime(player, mob, 663, 1, tpz.regime.type.GROUNDS)
end
