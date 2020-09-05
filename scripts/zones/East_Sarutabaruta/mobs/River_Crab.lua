-----------------------------------
-- Area: East Sarutabaruta
--  Mob: River Crab
-- Note: PH for Duke Decapod
-----------------------------------
require("scripts/globals/regimes")
-----------------------------------

function onMobDeath(mob, player, isKiller)
    tpz.regime.checkRegime(player, mob, 92, 1, tpz.regime.type.FIELDS)
end
