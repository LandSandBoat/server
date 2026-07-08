-----------------------------------
-- Area: Sea Serpent Grotto
--   NM: Pahh the Gullcaller
-----------------------------------
local ID = zones[xi.zone.SEA_SERPENT_GROTTO]
-----------------------------------
---@type TMobEntity
local entity = {}

entity.spawnPoints =
{
    { x =  -2.000, y = 21.000, z = -19.000 },
    { x =  -1.530, y = 21.715, z = -14.659 },
    { x =  -4.827, y = 20.686, z = -14.350 },
    { x =  -2.462, y = 21.242, z = -22.502 }
}

entity.phList =
{
    [ID.mob.PAHH_THE_GULLCALLER - 5] = ID.mob.PAHH_THE_GULLCALLER, -- -13.532 21.301 -20.861
}

entity.onMobInitialize = function(mob)
    mob:setMobMod(xi.mobMod.ALWAYS_AGGRO, 1)

    mob:addImmunity(xi.immunity.SILENCE)
    mob:addImmunity(xi.immunity.LIGHT_SLEEP)
    mob:addImmunity(xi.immunity.DARK_SLEEP)
    mob:addImmunity(xi.immunity.TERROR)
    mob:addImmunity(xi.immunity.PETRIFY)

    mob:setMobMod(xi.mobMod.GIL_MIN, 3600)
    mob:setMobMod(xi.mobMod.GIL_MAX, 3600)
end

entity.onMobSpawn = function(mob)
    mob:setMobMod(xi.mobMod.BASE_DAMAGE_MULTIPLIER, 150)

    mob:setMod(xi.mod.STORETP, 150)
end

entity.onMobDeath = function(mob, player, optParams)
    xi.hunts.checkHunt(mob, player, 375)
end

entity.onMobDespawn = function(mob)
    xi.mob.updateNMSpawnPoint(mob)
end

return entity
