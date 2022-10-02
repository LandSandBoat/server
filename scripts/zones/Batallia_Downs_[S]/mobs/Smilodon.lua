-----------------------------------
-- Area: Batallia Downs [S]
--  Mob: Smilodon
-- Note: PH for La Velue
-----------------------------------
local ID = require("scripts/zones/Batallia_Downs_[S]/IDs")
require("scripts/globals/mobs")
-----------------------------------
local entity = {}

entity.onMobDeath = function(mob, player, optParams)
end

entity.onMobDespawn = function(mob)
    xi.mob.phOnDespawn(mob, ID.mob.LA_VELUE_PH, 10, 3600) -- 1 hour
end

return entity
