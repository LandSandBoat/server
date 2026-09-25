-----------------------------------
-- Area: King Ranperres Tomb
--   NM: Gwyllgi
-----------------------------------
local ID = zones[xi.zone.KING_RANPERRES_TOMB]
-----------------------------------
---@type TMobEntity
local entity = {}

entity.phList =
{
    [ID.mob.GWYLLGI - 3] = ID.mob.GWYLLGI, -- Confirmed on retail
    [ID.mob.GWYLLGI - 2] = ID.mob.GWYLLGI, -- Confirmed on retail
}

entity.onMobDeath = function(mob, player, optParams)
    xi.hunts.checkHunt(mob, player, 177)
end

return entity
