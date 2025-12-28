-----------------------------------
-- Area: Vunkerl Inlet [S]
--   NM: Pallass Tiger
-----------------------------------
local entity = {}

entity.onMobInitialize = function(mob)
    mob:setLink(0)
end

entity.onMobSpawn = function(mob)
    mob:setMobMod(xi.mobMod.ADD_EFFECT, 1)
end

entity.onAdditionalEffect = function(mob, target, damage)
    -- level 99 got 15s paralyze once throughout whole fight
    return xi.mob.onAddEffect(mob, target, damage, xi.mob.ae.PARALYZE, { chance = 10, duration = 60 })
end

return entity
