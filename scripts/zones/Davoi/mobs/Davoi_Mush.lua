-----------------------------------
-- Area: Davoi
--  Mob: Davoi Mush
-- Note: PH for Blubbery Bulge
-----------------------------------
local ID = require("scripts/zones/Davoi/IDs")
require("scripts/globals/mobs")
-----------------------------------
local entity = {}

entity.onMobDeath = function(mob, player, isKiller)
end

function onMobDespawn(mob)
    tpz.mob.phOnDespawn(mob, ID.mob.BLUBBERY_BULGE_PH, 20, 3600) -- 1 hour
end

return entity
