-----------------------------------
-- Area: Upper Delkfutts Tower
--   NM: Ixtab
-----------------------------------
local ID = zones[xi.zone.UPPER_DELKFUTTS_TOWER]
-----------------------------------
---@type TMobEntity
local entity = {}

entity.phList =
{
    [ID.mob.IXTAB[1] - 3] = ID.mob.IXTAB[1],
    [ID.mob.IXTAB[1] - 2] = ID.mob.IXTAB[1],
    [ID.mob.IXTAB[1] - 1] = ID.mob.IXTAB[1],

    [ID.mob.IXTAB[2] - 3] = ID.mob.IXTAB[2],
    [ID.mob.IXTAB[2] - 2] = ID.mob.IXTAB[2],
    [ID.mob.IXTAB[2] - 1] = ID.mob.IXTAB[2],
}

entity.onMobDeath = function(mob, player, optParams)
    xi.hunts.checkHunt(mob, player, 332)
end

return entity
