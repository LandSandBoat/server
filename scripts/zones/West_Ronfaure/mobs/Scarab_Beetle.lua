-----------------------------------
-- Area: West Ronfaure(100)
--  Mob: Scarab Beetle
-- Note: Place holder for Fungus Beetle
-----------------------------------
local ID = require("scripts/zones/West_Ronfaure/IDs")
require("scripts/globals/regimes")
require("scripts/globals/mobs")
-----------------------------------
local entity = {}

entity.onMobDeath = function(mob, player, optParams)
    xi.regime.checkRegime(player, mob, 3, 1, xi.regime.type.FIELDS)
    xi.regime.checkRegime(player, mob, 4, 2, xi.regime.type.FIELDS)
end

entity.onMobDespawn = function(mob)
    xi.mob.phOnDespawn(mob, ID.mob.FUNGUS_BEETLE_PH, 10, 900) -- 15 minute minimum
end

return entity
