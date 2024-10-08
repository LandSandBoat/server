-----------------------------------
-- Area: Misareaux_Coast
--  Mob: Diatryma
-- Note: PH for Okyupete
-----------------------------------
local ID = zones[xi.zone.MISAREAUX_COAST]
-----------------------------------
---@type TMobEntity
local entity = {}

local okyupetePHTable =
{
    [ID.mob.OKYUPETE - 8] = ID.mob.OKYUPETE,
}

entity.onMobDeath = function(mob, player, optParams)
end

entity.onMobDespawn = function(mob)
    xi.mob.phOnDespawn(mob, okyupetePHTable, 10, 3600) -- 1 hour
end

return entity
