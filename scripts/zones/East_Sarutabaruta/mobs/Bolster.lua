-----------------------------------
-- Area: East Sarutabaruta
--  Mob: Bolster
-----------------------------------
require("scripts/globals/regimes")
-----------------------------------

function onMobDeath(mob, player, isKiller)
    tpz.regime.checkRegime(player, mob, 92, 2, tpz.regime.type.FIELDS)
    tpz.regime.checkRegime(player, mob, 93, 2, tpz.regime.type.FIELDS)
end
