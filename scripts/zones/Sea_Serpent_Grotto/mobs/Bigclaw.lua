-----------------------------------
-- Area: Sea Serpent Grotto
--  Mob: Bigclaw
-----------------------------------
require("scripts/globals/regimes")
-----------------------------------

function onMobDeath(mob, player, isKiller)
    tpz.regime.checkRegime(player, mob, 807, 2, tpz.regime.type.GROUNDS)
end
