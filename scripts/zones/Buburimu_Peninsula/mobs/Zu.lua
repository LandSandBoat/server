-----------------------------------
-- Area: Buburimu Peninsula (118)
--  Mob: Zu
-- Note: PH for Helldiver
-----------------------------------
local ID = zones[xi.zone.BUBURIMU_PENINSULA]
-----------------------------------
---@type TMobEntity
local entity = {}

entity.onMobDespawn = function(mob)
    xi.mob.phOnDespawn(mob, ID.mob.HELLDIVER, 10, 3600) -- 1 hour minimum
end

return entity
