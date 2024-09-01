-----------------------------------
-- Area: Upper Delkfutt's Tower
--  Mob: Phasma
-- Note: PH for Ixtab
-----------------------------------
local ID = zones[xi.zone.UPPER_DELKFUTTS_TOWER]
-----------------------------------
---@type TMobEntity
local entity = {}

local ixtabPHTable =
{
    [ID.mob.IXTAB[1] - 3] = ID.mob.IXTAB[1],
    [ID.mob.IXTAB[1] - 2] = ID.mob.IXTAB[1],
    [ID.mob.IXTAB[1] - 1] = ID.mob.IXTAB[1],

    [ID.mob.IXTAB[2] - 3] = ID.mob.IXTAB[2],
    [ID.mob.IXTAB[2] - 2] = ID.mob.IXTAB[2],
    [ID.mob.IXTAB[2] - 1] = ID.mob.IXTAB[2],
}

entity.onMobDeath = function(mob, player, optParams)
end

entity.onMobDespawn = function(mob)
    xi.mob.phOnDespawn(mob, ixtabPHTable, 5, 3600) -- 1 hour
end

return entity
