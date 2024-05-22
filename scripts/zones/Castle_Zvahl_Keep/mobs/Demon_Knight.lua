-----------------------------------
-- Area: Castle Zvahl Keep (162)
--  Mob: Demon Knight
-- Note: PH for Count Bifrons
-----------------------------------
local ID = zones[xi.zone.CASTLE_ZVAHL_KEEP]
-----------------------------------
local entity = {}

local bifronsPHTable =
{
    [ID.mob.COUNT_BIFRONS - 1] = ID.mob.COUNT_BIFRONS, -- -204.000 -52.125 -95.000
}

entity.onMobDeath = function(mob, player, optParams)
end

entity.onMobDespawn = function(mob)
    xi.mob.phOnDespawn(mob, bifronsPHTable, 10, 3600) -- 1 hour
end

return entity
