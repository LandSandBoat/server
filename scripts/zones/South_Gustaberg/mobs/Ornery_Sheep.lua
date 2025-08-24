-----------------------------------
-- Area: South Gustaberg
--  Mob: Ornery Sheep
-- Note: PH for Carnero
-----------------------------------
local ID = zones[xi.zone.SOUTH_GUSTABERG]
-----------------------------------
---@type TMobEntity
local entity = {}

entity.onMobDeath = function(mob, player, optParams)
end

entity.onMobDespawn = function(mob)
    xi.mob.phOnDespawn(mob, ID.mob.CARNERO, 5, 1) -- Pure lottery
end

return entity
