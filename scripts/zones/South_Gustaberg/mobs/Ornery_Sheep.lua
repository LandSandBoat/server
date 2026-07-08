-----------------------------------
-- Area: South Gustaberg
--  Mob: Ornery Sheep
-- Note: PH for Carnero
-----------------------------------
local ID = zones[xi.zone.SOUTH_GUSTABERG]
-----------------------------------
---@type TMobEntity
local entity = {}

entity.onMobDespawn = function(mob)
    xi.mob.phOnDespawn(mob, ID.mob.CARNERO, 10, 1) -- Pure lottery
end

return entity
