-----------------------------------
-- Area: Castle Oztroja (151)
--  Mob: Yagudo Herald
-- Note: PH for Quu Domi the Gallant
-----------------------------------
local ID = require("scripts/zones/Castle_Oztroja/IDs")
require("scripts/globals/mobs")
-----------------------------------
local entity = {}

entity.onMobDeath = function(mob, player, optParams)
end

entity.onMobDespawn = function(mob)
    xi.mob.phOnDespawn(mob, ID.mob.QUU_DOMI_THE_GALLANT_PH, 5, 3600) -- 1 hour
end

return entity
