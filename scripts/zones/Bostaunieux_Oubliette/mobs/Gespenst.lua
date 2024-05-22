-----------------------------------
-- Area: Bostaunieux Oubliette (167)
--  Mob: Gespenst
-- Note: PH for Manes
-----------------------------------
local ID = zones[xi.zone.BOSTAUNIEUX_OUBLIETTE]
-----------------------------------
local entity = {}

local manesPHTable =
{
    [ID.mob.MANES - 2] = ID.mob.MANES,
    [ID.mob.MANES - 1] = ID.mob.MANES,
    [ID.mob.MANES + 5] = ID.mob.MANES,
    [ID.mob.MANES + 6] = ID.mob.MANES,
}

entity.onMobDeath = function(mob, player, optParams)
end

entity.onMobDespawn = function(mob)
    xi.mob.phOnDespawn(mob, manesPHTable, 5, 3600) -- 1 hour
end

return entity
