-----------------------------------
-- Area: Castle Oztroja (151)
--  Mob: Yagudo Interrogator
-- Note: PH for Mee Deggi the Punisher
-----------------------------------
local ID = require("scripts/zones/Castle_Oztroja/IDs")
require("scripts/globals/mobs")
-----------------------------------
local entity = {}

entity.onMobDeath = function(mob, player, optParams)
end

entity.onMobDespawn = function(mob)
    xi.mob.phOnDespawn(mob, ID.mob.MEE_DEGGI_THE_PUNISHER_PH, 5, 3000) -- 50 minutes
end

return entity
