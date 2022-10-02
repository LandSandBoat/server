-----------------------------------
-- Area: Upper Delkfutt's Tower
--  Mob: Phasma
-- Note: PH for Ixtab
-----------------------------------
local ID = require("scripts/zones/Upper_Delkfutts_Tower/IDs")
require("scripts/globals/mobs")
-----------------------------------
local entity = {}

entity.onMobDeath = function(mob, player, optParams)
end

entity.onMobDespawn = function(mob)
    xi.mob.phOnDespawn(mob, ID.mob.IXTAB_PH, 5, 3600) -- 1 hour
end

return entity
