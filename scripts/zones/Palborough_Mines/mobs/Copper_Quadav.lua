-----------------------------------
-- Area: Palborough Mines
--  Mob: Copper Quadav
-- Note: PH for Be'Hya Hundredwall
-----------------------------------
local ID = zones[xi.zone.PALBOROUGH_MINES]
-----------------------------------
local entity = {}

local behyaPHTable =
{
    [ID.mob.BEHYA_HUNDREDWALL - 1] = ID.mob.BEHYA_HUNDREDWALL,
}

entity.onMobDeath = function(mob, player, optParams)
end

entity.onMobDespawn = function(mob)
    xi.mob.phOnDespawn(mob, behyaPHTable, 10, 3600) -- 1 hour
end

return entity
