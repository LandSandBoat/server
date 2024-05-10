-----------------------------------
-- Area: East Ronfaure [S]
--  Mob: Battrap
-- Note: PH for Goblintrap
-----------------------------------
local ID = zones[xi.zone.EAST_RONFAURE_S]
-----------------------------------
local entity = {}

local goblintrapPHTable =
{
    [ID.mob.GOBLINTRAP - 1] = ID.mob.GOBLINTRAP, -- 156 0 -438
}

entity.onMobDeath = function(mob, player, optParams)
end

entity.onMobDespawn = function(mob)
    xi.mob.phOnDespawn(mob, goblintrapPHTable, 5, 3600) -- 1 hour
end

return entity
