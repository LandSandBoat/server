-----------------------------------
-- Area: Xarcabard
--  Mob: Evil Eye
-- Note: PH for Shadow Eye
-----------------------------------
local ID = require("scripts/zones/Xarcabard/IDs")
require("scripts/globals/regimes")
require("scripts/globals/mobs")
-----------------------------------
local entity = {}

entity.onMobDeath = function(mob, player, optParams)
    xi.regime.checkRegime(player, mob, 53, 1, xi.regime.type.FIELDS)
    xi.regime.checkRegime(player, mob, 54, 2, xi.regime.type.FIELDS)
    xi.regime.checkRegime(player, mob, 55, 3, xi.regime.type.FIELDS)
end

entity.onMobDespawn = function(mob)
    xi.mob.phOnDespawn(mob, ID.mob.SHADOW_EYE_PH, 5, 3600) -- 1 hour
end

return entity
