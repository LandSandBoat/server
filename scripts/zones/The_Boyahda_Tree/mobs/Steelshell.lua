-----------------------------------
-- Area: The Boyahda Tree
--  Mob: Steelshell
-----------------------------------
require("scripts/globals/regimes")
-----------------------------------

function onMobDeath(mob, player, isKiller)
    tpz.regime.checkRegime(player, mob, 723, 2, tpz.regime.type.GROUNDS)
end
