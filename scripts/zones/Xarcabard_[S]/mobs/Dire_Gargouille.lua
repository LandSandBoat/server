-----------------------------------
-- Area: Xarcabard [S]
--  Mob: Dire Gargouille
-- Note: PH for Graoully
-----------------------------------
local ID = require("scripts/zones/Xarcabard_[S]/IDs")
require("scripts/globals/mobs")
-----------------------------------
local entity = {}

entity.onMobDeath = function(mob, player, isKiller)
end

function onMobDespawn(mob)
    tpz.mob.phOnDespawn(mob, ID.mob.GRAOULLY_PH, 10, 3600) -- 1 hour
end

return entity
