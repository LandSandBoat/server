-----------------------------------
-- Area: Fei'Yin
--  Mob: Killing Weapon
-----------------------------------
require("scripts/globals/regimes")
-----------------------------------

function onMobDeath(mob, player, isKiller)
    tpz.regime.checkRegime(player, mob, 716, 1, tpz.regime.type.GROUNDS)
end
