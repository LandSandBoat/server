-----------------------------------
-- Area: Outer Horutoto Ruins
--  Mob: Ghoul
-- Note: Place holder for Ah Puch
-----------------------------------
local ID = require("scripts/zones/Outer_Horutoto_Ruins/IDs")
require("scripts/globals/mobs")
-----------------------------------
local entity = {}

entity.onMobDeath = function(mob, player, optParams)
end

entity.onMobDespawn = function(mob)
    xi.mob.phOnDespawn(mob, ID.mob.AH_PUCH_PH, 20, 3600) -- 1 to 3 hours
end

return entity
