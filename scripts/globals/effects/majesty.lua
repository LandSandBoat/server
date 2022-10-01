-----------------------------------
-- xi.effect.MAJESTY
-----------------------------------
local effect_object = {}

effect_object.onEffectGain = function(target, effect)
    local strength = effect:getPower()

    target:addMod(xi.mod.CURE_POTENCY_II, strength)
    target:addMod(xi.mod.WHITE_MAGIC_RECAST, -strength)
end

effect_object.onEffectTick = function(target, effect)
end

effect_object.onEffectLose = function(target, effect)
    local strength = effect:getPower()

    target:delMod(xi.mod.CURE_POTENCY_II, strength)
    target:delMod(xi.mod.WHITE_MAGIC_RECAST, -strength)
end

return effect_object
