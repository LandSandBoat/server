-----------------------------------
-- Area: West Sarutabaruta
--  Mob: Mandragora
-- Note: PH for Tom Tit Tat
-----------------------------------
local ID = require("scripts/zones/West_Sarutabaruta/IDs")
require("scripts/globals/regimes")
require("scripts/globals/mobs")
-----------------------------------

function onMobDeath(mob, player, isKiller)
    tpz.regime.checkRegime(player, mob, 26, 1, tpz.regime.type.FIELDS)
end

function onMobDespawn(mob)
    tpz.mob.phOnDespawn(mob, ID.mob.TOM_TIT_TAT_PH, 7, math.random(3600, 7200)) -- 1 to 2 hours
end
