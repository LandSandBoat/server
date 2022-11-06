-----------------------------------
-- Area: East Sarutabaruta
--  Mob: Crawler
-- Note: PH for Spiny Spipi
-----------------------------------
local ID = require("scripts/zones/East_Sarutabaruta/IDs")
require("scripts/globals/regimes")
require("scripts/globals/mobs")
-----------------------------------
local entity = {}

entity.onMobDeath = function(mob, player, optParams)
    xi.regime.checkRegime(player, mob, 92, 2, xi.regime.type.FIELDS)
    xi.regime.checkRegime(player, mob, 93, 2, xi.regime.type.FIELDS)
end

entity.onMobDespawn = function(mob)
    xi.mob.phOnDespawn(mob, ID.mob.SPINY_SPIPI_PH, 10, 2700) -- 45 minute minimum
end

return entity
