-----------------------------------
-- Area: Temple of Uggalepih
--  Mob: Temple Bee
-----------------------------------
require("scripts/globals/regimes")
-----------------------------------

function onMobDeath(mob, player, isKiller)
    tpz.regime.checkRegime(player, mob, 790, 2, tpz.regime.type.GROUNDS)
    tpz.regime.checkRegime(player, mob, 793, 2, tpz.regime.type.GROUNDS)
end
