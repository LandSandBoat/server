-----------------------------------
-- Area: Meriphataud Mountains [S]
--  Mob: Mountain Scolopendrid
-- Note: PH for Centipedal Centruroides
-----------------------------------
local ID = zones[xi.zone.MERIPHATAUD_MOUNTAINS_S]
-----------------------------------
local entity = {}

local centipedalPHTable =
{
    [ID.mob.CENTIPEDAL_CENTRUROIDES - 1] = ID.mob.CENTIPEDAL_CENTRUROIDES,
}

entity.onMobDeath = function(mob, player, optParams)
end

entity.onMobDespawn = function(mob)
    xi.mob.phOnDespawn(mob, centipedalPHTable, 10, 3600) -- 1 hour
end

return entity
