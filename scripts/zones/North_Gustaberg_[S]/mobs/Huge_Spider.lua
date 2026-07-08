-----------------------------------
-- Area: North Gustaberg [S]
--  Mob: Huge Spider
-- Note: Place holder for Ankabut
-----------------------------------
local ID = zones[xi.zone.NORTH_GUSTABERG_S]
-----------------------------------
---@type TMobEntity
local entity = {}

entity.onMobDespawn = function(mob)
    xi.mob.phOnDespawn(mob, ID.mob.ANKABUT, 10, 3600) -- 1 hour
end

return entity
