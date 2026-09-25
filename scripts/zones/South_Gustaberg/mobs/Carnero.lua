-----------------------------------
-- Area: South Gustaberg
--   NM: Carnero
-----------------------------------
local ID = zones[xi.zone.SOUTH_GUSTABERG]
-----------------------------------
---@type TMobEntity
local entity = {}

entity.phList =
{
    [ID.mob.CARNERO[1] - 1]  = { ID.mob.CARNERO[1], ID.mob.CARNERO[2] }
}

entity.onMobDeath = function(mob, player, optParams)
    xi.hunts.checkHunt(mob, player, 202)
end

return entity
