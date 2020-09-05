-----------------------------------
-- Area: East Sarutabaruta
--  Mob: Savanna Rarab
-- Note: PH for Sharp Eared Ropipi
-----------------------------------
local ID = require("scripts/zones/East_Sarutabaruta/IDs")
require("scripts/globals/regimes")
require("scripts/globals/mobs")

function onMobDeath(mob, player, isKiller)
    tpz.regime.checkRegime(player, mob, 91, 1, tpz.regime.type.FIELDS)
end

function onMobDespawn(mob)
    tpz.mob.phOnDespawn(mob, ID.mob.SHARP_EARED_ROPIPI_PH, 20, 300) -- 5 minutes
end
