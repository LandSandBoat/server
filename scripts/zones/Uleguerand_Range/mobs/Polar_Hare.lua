-----------------------------------
-- Area: Uleguerand Range
--  Mob: Polar Hare
-- Note: PH for Skvader
-----------------------------------
local ID = zones[xi.zone.ULEGUERAND_RANGE]
-----------------------------------
local entity = {}

local ixtabPHTable =
{
    [ID.mob.SKVADER - 1] = ID.mob.SKVADER,
}

entity.onMobDeath = function(mob, player, optParams)
end

entity.onMobDespawn = function(mob)
    xi.mob.phOnDespawn(mob, ixtabPHTable, 10, 3600) -- 1 hour
end

return entity
