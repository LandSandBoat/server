-----------------------------------
-- Area: Temple of Uggalepih
--  Mob: Hover Tank
-----------------------------------
require("scripts/globals/regimes")
-----------------------------------

function onMobDeath(mob, player, isKiller)
    tpz.regime.checkRegime(player, mob, 794, 2, tpz.regime.type.GROUNDS)
end
