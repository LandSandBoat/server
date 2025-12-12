-----------------------------------
-- Area: One of many zones in Shadowreign zones
--   NM: Sandworm
-----------------------------------

xi = xi or {}
xi.sandworm = xi.sandworm or {}

xi.sandworm.onMobInitialize = function(mob)
    mob:addImmunity(xi.immunity.ELEGY)
    mob:addImmunity(xi.immunity.SLOW)
    mob:addImmunity(xi.immunity.LIGHT_SLEEP)
    mob:addImmunity(xi.immunity.DARK_SLEEP)
    mob:addImmunity(xi.immunity.PETRIFY)
    mob:addImmunity(xi.immunity.TERROR)
end
