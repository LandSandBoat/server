-----------------------------------
-- Area: Lufaise_Meadows
--  Mob: Gigantobugard
-- Note: PH for Megalobugard
-----------------------------------
local ID = zones[xi.zone.LUFAISE_MEADOWS]
-----------------------------------
---@type TMobEntity
local entity = {}

local megalobugardPHTable =
{
    [ID.mob.MEGALOBUGARD - 21] = ID.mob.MEGALOBUGARD, -- -137.168 -15.390 91.016
}

entity.onMobDeath = function(mob, player, optParams)
end

entity.onMobDespawn = function(mob)
    xi.mob.phOnDespawn(mob, megalobugardPHTable, 10, 3600) -- 1 hour
end

return entity
