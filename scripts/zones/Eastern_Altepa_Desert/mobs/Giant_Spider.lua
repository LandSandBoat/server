-----------------------------------
-- Area: Eastern Altepa Desert
--  Mob: Giant Spider
-- Note: PH for Dune Widow
-----------------------------------
local ID = require("scripts/zones/Eastern_Altepa_Desert/IDs")
require("scripts/globals/regimes")
require("scripts/globals/mobs")
-----------------------------------

function onMobDeath(mob, player, isKiller)
    tpz.regime.checkRegime(player, mob, 109, 1, tpz.regime.type.FIELDS)
end

function onMobDespawn(mob)
    tpz.mob.phOnDespawn(mob, ID.mob.DUNE_WIDOW_PH, 10, math.random(3600, 18000)) -- 1 to 5 hours
end
