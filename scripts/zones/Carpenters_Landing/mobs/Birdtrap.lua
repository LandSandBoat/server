-----------------------------------
-- Area: Carpenters' Landing
--  Mob: Birdtrap
-- Note: Placeholder Orctrap
-----------------------------------
local ID = zones[xi.zone.CARPENTERS_LANDING]
-----------------------------------
local entity = {}

local orctrapPHTable =
{
    [ID.mob.ORCTRAP - 1] = ID.mob.ORCTRAP, -- 181.819 -5.887 -524.872
}

entity.onMobDeath = function(mob, player, optParams)
end

entity.onMobDespawn = function(mob)
    xi.mob.phOnDespawn(mob, orctrapPHTable, 10, 3600) -- 1 hour minimum
end

return entity
