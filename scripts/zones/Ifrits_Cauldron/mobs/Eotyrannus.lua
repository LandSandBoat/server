-----------------------------------
-- Area: Ifrit's Cauldron
--  Mob: Eotyrannus
-- Note: PH for Lindwurm
-----------------------------------
local ID = zones[xi.zone.IFRITS_CAULDRON]
-----------------------------------
local entity = {}

local lindwurmPHTable =
{
    [ID.mob.LINDWURM - 6]  = ID.mob.LINDWURM,
    [ID.mob.LINDWURM - 5]  = ID.mob.LINDWURM,
    [ID.mob.LINDWURM - 2]  = ID.mob.LINDWURM,
    [ID.mob.LINDWURM - 1]  = ID.mob.LINDWURM,
    [ID.mob.LINDWURM + 18] = ID.mob.LINDWURM,
    [ID.mob.LINDWURM + 19] = ID.mob.LINDWURM,
}

entity.onMobDeath = function(mob, player, optParams)
    xi.regime.checkRegime(player, mob, 758, 1, xi.regime.type.GROUNDS)
end

entity.onMobDespawn = function(mob)
    xi.mob.phOnDespawn(mob, lindwurmPHTable, 5, 3600) -- 1 hour
end

return entity
