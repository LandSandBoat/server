-----------------------------------
-- Area: Xarcabard
--  Mob: Shadow Eye
-----------------------------------
local ID = zones[xi.zone.XARCABARD]
-----------------------------------
---@type TMobEntity
local entity = {}

entity.spawnPoints =
{
    { x = -236.734, y = -11.177, z = -23.543 }
}

entity.phList =
{
    [ID.mob.SHADOW_EYE - 6] = ID.mob.SHADOW_EYE,
}

entity.onMobDeath = function(mob, player, optParams)
    xi.hunts.checkHunt(mob, player, 315)
end

return entity
