-----------------------------------
-- Area: Eastern Altepa Desert
--  Mob: Lesser Manticore
-----------------------------------
require("scripts/globals/regimes")
-----------------------------------

function onMobDeath(mob, player, isKiller)
    tpz.regime.checkRegime(player, mob, 112, 4, tpz.regime.type.FIELDS)
    tpz.regime.checkRegime(player, mob, 113, 4, tpz.regime.type.FIELDS)
end
