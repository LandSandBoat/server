-----------------------------------
-- Area: East Ronfaure
--  Mob: Carrion Worm
-- Note: PH for Bigmouth Billy
-----------------------------------
local ID = require("scripts/zones/East_Ronfaure/IDs")
require("scripts/globals/regimes")
require("scripts/globals/mobs")
-----------------------------------
local entity = {}

entity.onMobDeath = function(mob, player, optParams)
    xi.regime.checkRegime(player, mob, 65, 1, xi.regime.type.FIELDS)
end

entity.onMobDespawn = function(mob)
    xi.mob.phOnDespawn(mob, ID.mob.BIGMOUTH_BILLY_PH, 7, 1300) -- 30 minute minimum
end

return entity
