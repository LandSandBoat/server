-----------------------------------
-- Area: Ifrits Cauldron
--   NM: Lindwurm
-----------------------------------
local ID = zones[xi.zone.IFRITS_CAULDRON]
-----------------------------------
---@type TMobEntity
local entity = {}

entity.spawnPoints =
{
    { x = -271.000, y =  3.700, z = -129.000 }
}

entity.phList =
{
    [ID.mob.LINDWURM - 6]  = ID.mob.LINDWURM,
    [ID.mob.LINDWURM - 5]  = ID.mob.LINDWURM,
    [ID.mob.LINDWURM - 2]  = ID.mob.LINDWURM,
    [ID.mob.LINDWURM - 1]  = ID.mob.LINDWURM,
    [ID.mob.LINDWURM + 18] = ID.mob.LINDWURM,
    [ID.mob.LINDWURM + 19] = ID.mob.LINDWURM,
}

entity.onMobDeath = function(mob, player, optParams)
    xi.hunts.checkHunt(mob, player, 401)
end

return entity
