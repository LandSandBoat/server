-----------------------------------
-- Area: Uleguerand Range
--  Mob: Polar Hare
-- Note: PH for Skvader
-----------------------------------
local ID = zones[xi.zone.ULEGUERAND_RANGE]
-----------------------------------
---@type TMobEntity
local entity = {}

entity.onMobDespawn = function(mob)
    xi.mob.phOnDespawn(mob, ID.mob.SKVADER, 10, 3600) -- 1 hour
end

return entity
