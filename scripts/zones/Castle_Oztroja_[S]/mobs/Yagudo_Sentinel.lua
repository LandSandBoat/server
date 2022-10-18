-----------------------------------
-- Area: Castle Oztroja [S]
--  Mob: Yagudo Sentinel
-- Note: PH for Aa Xalmo the Savage and Zhuu Buxu the Silent
-----------------------------------
local ID = require("scripts/zones/Castle_Oztroja_[S]/IDs")
require("scripts/globals/mobs")
-----------------------------------
local entity = {}

entity.onMobDeath = function(mob, player, optParams)
end

entity.onMobDespawn = function(mob)
    xi.mob.phOnDespawn(mob, ID.mob.AA_XALMO_THE_SAVAGE_PH, 10, 7200) -- 2 hour
    xi.mob.phOnDespawn(mob, ID.mob.ZHUU_BUXU_THE_SILENT_PH, 10, 7200) -- 2 hour
end

return entity
