-----------------------------------
-- Area: Sea Serpent Grotto
--   NM: Qull the Shellbuster
-----------------------------------
mixins = { require('scripts/mixins/job_special') }
-----------------------------------
local ID = zones[xi.zone.SEA_SERPENT_GROTTO]
-----------------------------------
---@type TMobEntity
local entity = {}

entity.spawnPoints =
{
    { x =  391.000, y =  9.000, z = -59.000 }
}

entity.phList =
{
    [ID.mob.QULL_THE_SHELLBUSTER - 5] = ID.mob.QULL_THE_SHELLBUSTER, -- 348.293 10.133 -65.543
    [ID.mob.QULL_THE_SHELLBUSTER - 2] = ID.mob.QULL_THE_SHELLBUSTER, -- 363.430 10.578 -62.752
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
end

entity.onMobDeath = function(mob, player, optParams)
    xi.hunts.checkHunt(mob, player, 373)
end

return entity
