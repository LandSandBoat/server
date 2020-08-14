-----------------------------------
-- Area: The Boyahda Tree
--  Mob: Snaggletooth Peapuk
-----------------------------------
require("scripts/globals/regimes")
-----------------------------------

function onMobDeath(mob, player, isKiller)
    tpz.regime.checkRegime(player, mob, 726, 2, tpz.regime.type.GROUNDS)
end
