-----------------------------------
-- Area: Buburimu Peninsula (118)
--  Mob: Zu
-- Note: PH for Helldiver
-----------------------------------
local ID = require("scripts/zones/Buburimu_Peninsula/IDs")
require("scripts/globals/mobs")
-----------------------------------
local entity = {}

entity.onMobDeath = function(mob, player, optParams)
end

entity.onMobDespawn = function(mob)
    xi.mob.phOnDespawn(mob, ID.mob.HELLDIVER_PH, 10, 3600) -- 1 hour minimum
end

return entity
