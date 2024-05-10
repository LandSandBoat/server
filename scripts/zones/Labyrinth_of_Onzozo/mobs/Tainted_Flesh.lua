-----------------------------------
-- Area: Labyrinth of Onzozo
--  Mob: Tainted Flesh
-- Note: Place holder for Hellion
-----------------------------------
local ID = zones[xi.zone.LABYRINTH_OF_ONZOZO]
-----------------------------------
local entity = {}

local hellionPHTable =
{
    [ID.mob.HELLION + 2]  = ID.mob.HELLION, -- 136.566 14.708 70.077
    [ID.mob.HELLION + 15] = ID.mob.HELLION, -- 127.523 14.327 210.258
}

entity.onMobDeath = function(mob, player, optParams)
end

entity.onMobDespawn = function(mob)
    xi.mob.phOnDespawn(mob, hellionPHTable, 10, 7200) -- 2 hour minimum
end

return entity
