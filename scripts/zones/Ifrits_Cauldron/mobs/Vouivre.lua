-----------------------------------
-- Area: Ifrits Cauldron
--   NM: Vouivre
-----------------------------------
local ID = zones[xi.zone.IFRITS_CAULDRON]
-----------------------------------
---@type TMobEntity
local entity = {}

entity.spawnPoints =
{
    { x = -38.587, y = 3.181, z = 259.578 },
    { x = -37.041, y = 4.000, z = 273.736 },
    { x = -18.305, y = 3.864, z = 243.227 },
    { x =   0.868, y = 4.000, z = 261.133 },
    { x = -17.929, y = 3.732, z = 284.440 }
}

entity.phList =
{
    [ID.mob.VOUIVRE - 13] = ID.mob.VOUIVRE,
    [ID.mob.VOUIVRE - 12] = ID.mob.VOUIVRE,
    [ID.mob.VOUIVRE - 9]  = ID.mob.VOUIVRE,
    [ID.mob.VOUIVRE - 8]  = ID.mob.VOUIVRE,
    [ID.mob.VOUIVRE - 5]  = ID.mob.VOUIVRE,
    [ID.mob.VOUIVRE - 1]  = ID.mob.VOUIVRE,
}

entity.onMobInitialize = function(mob)
    mob:addImmunity(xi.immunity.SILENCE)
    mob:addImmunity(xi.immunity.LIGHT_SLEEP)
    mob:addImmunity(xi.immunity.DARK_SLEEP)
    mob:addImmunity(xi.immunity.TERROR)
    mob:addImmunity(xi.immunity.PETRIFY)

    mob:setMobMod(xi.mobMod.GIL_MIN, 18000)
    mob:setMobMod(xi.mobMod.GIL_MAX, 18000)
end

entity.onMobSpawn = function(mob)
    mob:setMobMod(xi.mobMod.BASE_DAMAGE_MULTIPLIER, 150)
    mob:setMod(xi.mod.REGEN, 50)
    mob:setMod(xi.mod.DOUBLE_ATTACK, 50)
    mob:setMod(xi.mod.TRIPLE_ATTACK, 30)
end

entity.onMobDeath = function(mob, player, optParams)
    xi.hunts.checkHunt(mob, player, 402)
end

entity.onMobDespawn = function(mob)
    xi.mob.updateNMSpawnPoint(mob)
end

return entity
