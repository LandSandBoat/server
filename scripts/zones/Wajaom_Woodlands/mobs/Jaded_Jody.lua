-----------------------------------
-- Area: Wajaom Woodlands
--  Mob: Jaded Jody
-----------------------------------
local ID = zones[xi.zone.WAJAOM_WOODLANDS]
-----------------------------------
---@type TMobEntity
local entity = {}

entity.spawnPoints =
{
    { x = -572.000, y = -8.500, z = -335.000 }
}

entity.phList =
{
    [ID.mob.JADED_JODY - 2]  = ID.mob.JADED_JODY, -- -560 -8 -360
    [ID.mob.JADED_JODY + 12] = ID.mob.JADED_JODY, -- -565 -7 -324
}

entity.onMobDeath = function(mob, player, optParams)
    xi.hunts.checkHunt(mob, player, 448)
end

return entity
