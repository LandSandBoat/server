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
    { x = -271.000, y =  3.700, z = -129.000 },
    { x = -277.875, y =  3.960, z = -149.239 },
    { x = -238.112, y =  4.000, z = -143.615 },
    { x = -249.902, y =  4.000, z = -119.366 },
    { x = -279.284, y =  4.000, z = -117.433 }
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

entity.onMobInitialize = function(mob)
    mob:addImmunity(xi.immunity.LIGHT_SLEEP)
    mob:addImmunity(xi.immunity.DARK_SLEEP)
    mob:addImmunity(xi.immunity.TERROR)

    mob:setMobMod(xi.mobMod.GIL_MIN, 18000)
    mob:setMobMod(xi.mobMod.GIL_MAX, 18000)
end

entity.onMobSpawn = function(mob)
    mob:setMobMod(xi.mobMod.BASE_DAMAGE_MULTIPLIER, 150)
    mob:setMod(xi.mod.DOUBLE_ATTACK, 10)
    mob:setMod(xi.mod.TRIPLE_ATTACK, 15)
end

entity.onMobDeath = function(mob, player, optParams)
    xi.hunts.checkHunt(mob, player, 401)
end

entity.onMobDespawn = function(mob)
    xi.mob.updateNMSpawnPoint(mob)
end

return entity
