-----------------------------------
-- Area: Buburimu Peninsula (118)
--  Mob: Shoal Pugil
-- Note: PH for Buburimboo
-----------------------------------
local ID = zones[xi.zone.BUBURIMU_PENINSULA]
-----------------------------------
---@type TMobEntity
local entity = {}

local buburimbooPHTable =
{
    [ID.mob.BUBURIMBOO - 1] = ID.mob.BUBURIMBOO, -- 442.901 19.500 109.075
}

entity.onMobDeath = function(mob, player, optParams)
    xi.regime.checkRegime(player, mob, 62, 1, xi.regime.type.FIELDS)
end

entity.onMobDespawn = function(mob)
    xi.mob.phOnDespawn(mob, buburimbooPHTable, 10, 3600) -- 1 hour minimum
end

return entity
