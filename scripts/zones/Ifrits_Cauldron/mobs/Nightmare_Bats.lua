-----------------------------------
-- Area: Ifrit's Cauldron
--  Mob: Nightmare Bats
-----------------------------------
require("scripts/globals/regimes")
-----------------------------------

function onMobDeath(mob, player, isKiller)
    tpz.regime.checkRegime(player, mob, 760, 1, tpz.regime.type.GROUNDS)
end
