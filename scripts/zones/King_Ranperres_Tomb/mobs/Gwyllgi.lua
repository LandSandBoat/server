-----------------------------------
-- Area: King Ranperres Tomb
--   NM: Gwyllgi
-----------------------------------
local ID = zones[xi.zone.KING_RANPERRES_TOMB]
-----------------------------------
---@type TMobEntity
local entity = {}

entity.spawnPoints =
{
    { x = -65.363, y =  7.726, z =  75.649 }
}

entity.phList =
{
    [ID.mob.GWYLLGI - 3] = ID.mob.GWYLLGI,
}

entity.onMobDeath = function(mob, player, optParams)
    xi.hunts.checkHunt(mob, player, 177)
end

return entity
