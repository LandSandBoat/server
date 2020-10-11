-----------------------------------
-- Area: Den of Rancor
--  Mob: Succubus Bats
-----------------------------------
require("scripts/globals/regimes")
-----------------------------------

function onMobDeath(mob, player, isKiller)
    tpz.regime.checkRegime(player, mob, 799, 1, tpz.regime.type.GROUNDS)
end
