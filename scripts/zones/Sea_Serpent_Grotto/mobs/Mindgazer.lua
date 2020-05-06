-----------------------------------
-- Area: Sea Serpent Grotto
--  Mob: Mindgazer
-----------------------------------
require("scripts/globals/regimes")
-----------------------------------

function onMobDeath(mob, player, isKiller)
    tpz.regime.checkRegime(player, mob, 811, 1, tpz.regime.type.GROUNDS)
end
