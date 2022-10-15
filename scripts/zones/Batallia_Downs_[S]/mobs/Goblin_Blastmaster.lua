-----------------------------------
-- Area: Batallia Downs [S]
--  Mob: Goblin Blastmaster
-- Note: PH for Burlibix Brawnback
-----------------------------------
local ID = require("scripts/zones/Batallia_Downs_[S]/IDs")
require("scripts/globals/mobs")
-----------------------------------
local entity = {}

entity.onMobDeath = function(mob, player, optParams)
end

entity.onMobDespawn = function(mob)
    xi.mob.phOnDespawn(mob, ID.mob.BURLIBIX_BRAWNBACK_PH, 10, 10800) -- 3 hours
end

return entity
