-----------------------------------
-- Area: Uleguerand Range
--  Mob: Molech
-- Note: PH for Magnotaur
-----------------------------------
local ID = require("scripts/zones/Uleguerand_Range/IDs")
require("scripts/globals/mobs")
-----------------------------------
local entity = {}

entity.onMobDeath = function(mob, player, optParams)
end

entity.onMobDespawn = function(mob)
    xi.mob.phOnDespawn(mob, ID.mob.MAGNOTAUR_PH, 10, 3600) -- 1 hour
end

return entity
