-----------------------------------
-- Area: Palborough Mines
--  Mob: Old Quadav
-- Note: PH for Be'Hya Hundredwall
-----------------------------------
local ID = zones[xi.zone.PALBOROUGH_MINES]
-----------------------------------
---@type TMobEntity
local entity = {}

local behyaPHTable =
{
    [ID.mob.BEHYA_HUNDREDWALL - 2] = ID.mob.BEHYA_HUNDREDWALL,
}

entity.onMobDeath = function(mob, player, optParams)
end

entity.onMobDespawn = function(mob)
    xi.mob.phOnDespawn(mob, behyaPHTable, 10, 3600) -- 1 hour
end

return entity
