-----------------------------------
-- xi.effect.MAJESTY
-----------------------------------
local effectObject = {}

effectObject.onEffectGain = function(target, effect)
    local strength = effect:getPower()

    target:addMod(xi.mod.CURE_POTENCY_II, strength)
    target:addMod(xi.mod.WHITE_MAGIC_RECAST, -strength)
end

effectObject.onEffectTick = function(target, effect)
end

effectObject.onEffectLose = function(target, effect)
    local strength = effect:getPower()

    target:delMod(xi.mod.CURE_POTENCY_II, strength)
    target:delMod(xi.mod.WHITE_MAGIC_RECAST, -strength)
end

return effectObject
