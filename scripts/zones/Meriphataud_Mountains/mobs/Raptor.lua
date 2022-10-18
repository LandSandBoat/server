-----------------------------------
-- Area: Meriphataud Mountains
--  Mob: Raptor
-- Note: PH for Daggerclaw Dracos
-----------------------------------
local ID = require("scripts/zones/Meriphataud_Mountains/IDs")
require("scripts/globals/regimes")
require("scripts/globals/mobs")
-----------------------------------
local entity = {}

entity.onMobDeath = function(mob, player, optParams)
    xi.regime.checkRegime(player, mob, 39, 1, xi.regime.type.FIELDS)
end

entity.onMobDespawn = function(mob)
    xi.mob.phOnDespawn(mob, ID.mob.DAGGERCLAW_DRACOS_PH, 10, 3600) -- 1 hour
end

return entity
