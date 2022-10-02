-----------------------------------
-- Area: Valkurm Dunes
--  Mob: Damselfly
-- Note: Place holder Valkurm Emperor
-----------------------------------
local ID = require("scripts/zones/Valkurm_Dunes/IDs")
require("scripts/globals/regimes")
require("scripts/globals/mobs")
-----------------------------------
local entity = {}

entity.onMobDeath = function(mob, player, optParams)
    xi.regime.checkRegime(player, mob, 9, 1, xi.regime.type.FIELDS)
    xi.regime.checkRegime(player, mob, 10, 2, xi.regime.type.FIELDS)
end

entity.onMobDespawn = function(mob)
    xi.mob.phOnDespawn(mob, ID.mob.VALKURM_EMPEROR_PH, 10, 3600) -- 1 hour
end

return entity
