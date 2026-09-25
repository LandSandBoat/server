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

entity.phList =
{
    [ID.mob.VOLL_THE_SHARKFINNED - 2] = ID.mob.VOLL_THE_SHARKFINNED, -- Confirmed on retail
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
end

return entity
