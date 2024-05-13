-----------------------------------
-- Area: Grauberg [S]
--  Mob: Ajattara
-- Note: PH for Scitalis
-----------------------------------
local ID = zones[xi.zone.GRAUBERG_S]
-----------------------------------
local entity = {}

local scitalisPHTable =
{
    [ID.mob.SCITALIS - 1] = ID.mob.SCITALIS,
}

entity.onMobDeath = function(mob, player, optParams)
end

entity.onMobDespawn = function(mob)
    xi.mob.phOnDespawn(mob, scitalisPHTable, 10, 3600) -- 1 hour
end

return entity
