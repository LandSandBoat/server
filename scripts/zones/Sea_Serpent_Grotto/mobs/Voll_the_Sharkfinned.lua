-----------------------------------
-- Area: Sea Serpent Grotto
--   NM: Voll the Sharkfinned
-----------------------------------
mixins = { require('scripts/mixins/job_special') }
-----------------------------------
local ID = zones[xi.zone.SEA_SERPENT_GROTTO]
-----------------------------------
---@type TMobEntity
local entity = {}

entity.spawnPoints =
{
    { x = -320.000, y =  16.000, z =  -98.000 },
    { x = -336.638, y =  16.000, z = -105.668 },
    { x = -340.996, y =  16.000, z =  -95.725 },
    { x = -320.000, y =  16.000, z =  -98.000 },
    { x = -328.876, y =  16.000, z =  -94.524 },
    { x = -316.943, y =  16.000, z =  -97.724 },
    { x = -350.830, y =  15.475, z = -103.219 }
}

entity.phList =
{
    [ID.mob.VOLL_THE_SHARKFINNED - 2] = ID.mob.VOLL_THE_SHARKFINNED, -- -337.035 16.950 -106.841
}

entity.onMobInitialize = function(mob)
    mob:addImmunity(xi.immunity.SILENCE)
    mob:addImmunity(xi.immunity.LIGHT_SLEEP)
    mob:addImmunity(xi.immunity.DARK_SLEEP)
    mob:addImmunity(xi.immunity.TERROR)
    mob:addImmunity(xi.immunity.PETRIFY)

    mob:setMobMod(xi.mobMod.GIL_MIN, 3000)
    mob:setMobMod(xi.mobMod.GIL_MAX, 3000)
end

entity.onMobSpawn = function(mob)
    mob:setMobMod(xi.mobMod.BASE_DAMAGE_MULTIPLIER, 150)
end

entity.onMobDeath = function(mob, player, optParams)
    xi.hunts.checkHunt(mob, player, 378)
end

entity.onMobDespawn = function(mob)
    xi.mob.updateNMSpawnPoint(mob)
end

return entity
