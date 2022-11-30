-----------------------------------
-- Area: Castle Oztroja (151)
--  Mob: Yagudo Conquistador
-- Note: PH for Yaa Haqa the Profane
-----------------------------------
local ID = require("scripts/zones/Castle_Oztroja/IDs")
require("scripts/globals/mobs")
-----------------------------------
local entity = {}

entity.onMobDeath = function(mob, player, optParams)
end

entity.onMobDespawn = function(mob)
    xi.mob.phOnDespawn(mob, ID.mob.YAA_HAQA_THE_PROFANE_PH, 5, 3600) -- 1 hour
end

return entity
