-----------------------------------
-- Area: Eastern Altepa Desert
--  Mob: Antican Speculator
-----------------------------------
require("scripts/globals/regimes")
-----------------------------------

function onMobDeath(mob, player, isKiller)
    tpz.regime.checkRegime(player, mob, 112, 3, tpz.regime.type.FIELDS)
end
