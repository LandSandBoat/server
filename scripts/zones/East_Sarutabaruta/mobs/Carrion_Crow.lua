-----------------------------------
-- Area: East Sarutabaruta
--  Mob: Carrion Crow
-----------------------------------
require("scripts/globals/regimes")
-----------------------------------

function onMobDeath(mob, player, isKiller)
    tpz.regime.checkRegime(player, mob, 93, 1, tpz.regime.type.FIELDS)
end
