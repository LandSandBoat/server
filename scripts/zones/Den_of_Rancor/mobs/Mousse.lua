-----------------------------------
-- Area: Den of Rancor
--  Mob: Mousse
-----------------------------------
require("scripts/globals/regimes")
-----------------------------------

function onMobDeath(mob, player, isKiller)
    tpz.regime.checkRegime(player, mob, 797, 2, tpz.regime.type.GROUNDS)
end
