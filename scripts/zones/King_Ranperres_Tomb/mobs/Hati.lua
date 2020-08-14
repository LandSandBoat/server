-----------------------------------
-- Area: King Ranperres Tomb
--  Mob: Hati
-----------------------------------
require("scripts/globals/regimes")
-----------------------------------

function onMobDeath(mob, player, isKiller)
    tpz.regime.checkRegime(player, mob, 637, 2, tpz.regime.type.GROUNDS)
end
