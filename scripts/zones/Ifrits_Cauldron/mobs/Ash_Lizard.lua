-----------------------------------
-- Area: Ifrit's Cauldron
--  Mob: Ash Lizard
-----------------------------------
require("scripts/globals/regimes")
-----------------------------------

function onMobDeath(mob, player, isKiller)
    tpz.regime.checkRegime(player, mob, 761, 1, tpz.regime.type.GROUNDS)
end
