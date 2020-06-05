-----------------------------------
-- Area: Sea Serpent Grotto
--  Mob: Undead Bats
-----------------------------------
require("scripts/globals/regimes")
-----------------------------------

function onMobDeath(mob, player, isKiller)
    tpz.regime.checkRegime(player, mob, 804, 2, tpz.regime.type.GROUNDS)
end
