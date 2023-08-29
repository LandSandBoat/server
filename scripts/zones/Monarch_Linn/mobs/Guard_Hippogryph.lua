-----------------------------------
-- Area: Monarch Linn
-- Mob: Guard Hippogryph
-- ENM: Beloved of the Atlantes
-----------------------------------
-----------------------------------

local entity = {}

entity.onMobInitialize = function(mob)
    mob:setMobMod(xi.mobMod.ADD_EFFECT, 1)
end

entity.onAdditionalEffect = function(mob, target, damage)
    return xi.mob.onAddEffect(mob, target, damage, xi.mob.ae.HP_DRAIN)
end

return entity
