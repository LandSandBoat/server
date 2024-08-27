-----------------------------------
-- Area: Jade Sepulcher
--   NM: Mocking Colibri
-----------------------------------
mixins = { require('scripts/mixins/families/colibri_mimic') }
-----------------------------------
local entity = {}

entity.onMobInitialize = function(mob)
end

entity.onMobSpawn = function(mob)
    mob:addImmunity(xi.immunity.SILENCE)
    mob:addImmunity(xi.immunity.DARK_SLEEP)
    mob:addImmunity(xi.immunity.LIGHT_SLEEP)
end

entity.onMobDisengage = function(mob)
    -- Remove dots when the mob disengages such as when charming everyone
    mob:delStatusEffect(xi.effect.POISON)
    mob:delStatusEffect(xi.effect.BURN)
    mob:delStatusEffect(xi.effect.FROST)
    mob:delStatusEffect(xi.effect.CHOKE)
    mob:delStatusEffect(xi.effect.RASP)
    mob:delStatusEffect(xi.effect.SHOCK)
    mob:delStatusEffect(xi.effect.DROWN)
    mob:delStatusEffect(xi.effect.DIA)
    mob:delStatusEffect(xi.effect.BIO)
end

entity.onMobDeath = function(mob, player, optParams)
end

return entity
