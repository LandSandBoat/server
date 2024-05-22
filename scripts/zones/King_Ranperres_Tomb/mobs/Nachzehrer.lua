-----------------------------------
-- Area: King Ranperres Tomb
--  Mob: Nachzehrer
-- Note: PH for Gwyllgi
-----------------------------------
local ID = zones[xi.zone.KING_RANPERRES_TOMB]
-----------------------------------
local entity = {}

local gwyllgiPHTable =
{
    [ID.mob.GWYLLGI - 3] = ID.mob.GWYLLGI,
}

entity.onMobDeath = function(mob, player, optParams)
end

entity.onMobDespawn = function(mob)
    xi.mob.phOnDespawn(mob, gwyllgiPHTable, 10, 3600) -- 1 hour
end

return entity
