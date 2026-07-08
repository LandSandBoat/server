-----------------------------------
-- Area: Upper Delkfutt's Tower
--  Mob: Phasma
-- Note: PH for Ixtab
-----------------------------------
local ID = zones[xi.zone.UPPER_DELKFUTTS_TOWER]
-----------------------------------
---@type TMobEntity
local entity = {}

entity.onMobDespawn = function(mob)
    xi.mob.phOnDespawn(mob, ID.mob.IXTAB[1], 5, 3600) -- 1 hour
end

return entity
