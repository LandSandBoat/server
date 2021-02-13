-----------------------------------
-- Area: Wajaom Woodlands
--  Mob: Great Ameretat
-- Note: PH for Jaded Jody
-----------------------------------
local ID = require("scripts/zones/Wajaom_Woodlands/IDs")
require("scripts/globals/mobs")
-----------------------------------
local entity = {}

entity.onMobDeath = function(mob, player, isKiller)
end

entity.onMobDespawn = function(mob)
    tpz.mob.phOnDespawn(mob, ID.mob.JADED_JODY_PH, 10, 7200) -- 2 hours
end

return entity
