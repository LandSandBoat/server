-----------------------------------
-- Area: Eastern Altepa Desert
--  Mob: Desert Dhalmel
-----------------------------------
require("scripts/globals/regimes")
-----------------------------------

function onMobDeath(mob, player, isKiller)
    tpz.regime.checkRegime(player, mob, 111, 3, tpz.regime.type.FIELDS)
end
