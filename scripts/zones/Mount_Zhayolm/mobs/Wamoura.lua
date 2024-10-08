-----------------------------------
-- Area: Mount Zhayolm
--  Mob: Wamoura
-- Note: PH for Ignamoth
-----------------------------------
local ID = zones[xi.zone.MOUNT_ZHAYOLM]
-----------------------------------
---@type TMobEntity
local entity = {}

local ignamothPHTable =
{
    [ID.mob.IGNAMOTH - 2] = ID.mob.IGNAMOTH, -- -567.6 -15.35 252.201
    [ID.mob.IGNAMOTH - 1] = ID.mob.IGNAMOTH, -- -544.3 -14.8 262.992
}

entity.onMobDeath = function(mob)
end

entity.onMobDespawn = function(mob)
    xi.mob.phOnDespawn(mob, ignamothPHTable, 10, 7200) -- 2 hours
end

return entity
