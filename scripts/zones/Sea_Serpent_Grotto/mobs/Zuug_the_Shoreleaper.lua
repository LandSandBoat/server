-----------------------------------
-- Area: Sea Serpent Grotto
--   NM: Zuug the Shoreleaper
-----------------------------------
mixins = { require('scripts/mixins/job_special') }
-----------------------------------
local ID = zones[xi.zone.SEA_SERPENT_GROTTO]
-----------------------------------
---@type TMobEntity
local entity = {}

entity.phList =
{
    [ID.mob.ZUUG_THE_SHORELEAPER - 3] = ID.mob.ZUUG_THE_SHORELEAPER, -- Confirmed on retail
}

entity.onMobInitialize = function(mob)
    xi.pet.setMobPet(mob, 1, 'Sahagins_Wyvern')

    mob:addImmunity(xi.immunity.SILENCE)
    mob:addImmunity(xi.immunity.LIGHT_SLEEP)
    mob:addImmunity(xi.immunity.DARK_SLEEP)
    mob:addImmunity(xi.immunity.TERROR)
    mob:addImmunity(xi.immunity.PETRIFY)

    mob:setMobMod(xi.mobMod.GIL_MIN, 6000)
    mob:setMobMod(xi.mobMod.GIL_MAX, 6000)
end

entity.onMobSpawn = function(mob)
    mob:setMobMod(xi.mobMod.BASE_DAMAGE_MULTIPLIER, 150)

    mob:setMod(xi.mod.STORETP, 100)
end

entity.onMobDeath = function(mob, player, optParams)
    xi.hunts.checkHunt(mob, player, 382)
end

entity.onMobDespawn = function(mob)
end

return entity
