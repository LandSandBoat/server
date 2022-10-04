-----------------------------------
-- Area: Grauberg [S]
--  Mob: Ajattara
-- Note: PH for Scitalis
-----------------------------------
local ID = require("scripts/zones/Grauberg_[S]/IDs")
require("scripts/globals/mobs")
-----------------------------------
local entity = {}

entity.onMobDeath = function(mob, player, optParams)
end

entity.onMobDespawn = function(mob)
    xi.mob.phOnDespawn(mob, ID.mob.SCITALIS_PH, 5, 3600) -- 1 hour
end

return entity
