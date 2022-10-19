-----------------------------------
-- Area: Qufim Island
--  Mob: Giant Trapper
-- Note: PH for Slippery Sucker
-----------------------------------
local ID = require("scripts/zones/Qufim_Island/IDs")
require("scripts/globals/regimes")
require("scripts/globals/mobs")
-----------------------------------
local entity = {}

entity.onMobDeath = function(mob, player, optParams)
    xi.regime.checkRegime(player, mob, 44, 1, xi.regime.type.FIELDS)
    xi.regime.checkRegime(player, mob, 45, 2, xi.regime.type.FIELDS)
end

entity.onMobDespawn = function(mob)
    xi.mob.phOnDespawn(mob, ID.mob.SLIPPERY_SUCKER_PH, 10, 600) -- 10 minutes
end

return entity
