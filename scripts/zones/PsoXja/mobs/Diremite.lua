-----------------------------------
-- Area: Pso'Xja
--  Mob: Diremite
-----------------------------------
local ID = zones[xi.zone.PSOXJA]
-----------------------------------
local entity = {}

local gyreCarlinPHTable =
{
    [ID.mob.GYRE_CARLIN - 1] = ID.mob.GYRE_CARLIN,
}

entity.onMobDeath = function(mob, player, optParams)
end

entity.onMobDespawn = function(mob)
    xi.mob.phOnDespawn(mob, gyreCarlinPHTable, 5, 1800) -- 30 minutes.
end

return entity
