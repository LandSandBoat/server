-----------------------------------
-- Area: Mount Zhayolm
--  Mob: Wamoura
-- Note: PH for Ignamoth
-----------------------------------
local ID = zones[xi.zone.MOUNT_ZHAYOLM]
require("scripts/globals/mobs")
-----------------------------------
local entity = {}

entity.onMobDeath = function(mob)
end

entity.onMobDespawn = function(mob)
    xi.mob.phOnDespawn(mob, ID.mob.IGNAMOTH_PH, 10, 7200) -- 2 hours
end

return entity
