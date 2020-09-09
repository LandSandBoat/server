-----------------------------------
-- Area: Cape Teriggan
--  Mob: Beach Bunny
-----------------------------------
require("scripts/globals/regimes")
-----------------------------------

function onMobDeath(mob, player, isKiller)
    tpz.regime.checkRegime(player, mob, 104, 1, tpz.regime.type.FIELDS)
end
