-----------------------------------
-- Area: Outer Horutoto Ruins
--  Mob: Four of Swords
-----------------------------------
require("scripts/globals/regimes")
-----------------------------------

function onMobDeath(mob, player, isKiller)
    tpz.regime.checkRegime(player, mob, 663, 3, tpz.regime.type.GROUNDS)
end
