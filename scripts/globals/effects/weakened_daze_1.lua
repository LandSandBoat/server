-----------------------------------
-- xi.effect.WEAKENED_DAZE_1
-----------------------------------
local effectObject = {}

effectObject.onEffectGain = function(target, effect)
    local effectPower = effect:getPower()

    target:addMod(xi.mod.MEVA, effectPower * -3)
end

effectObject.onEffectTick = function(target, effect)
end

effectObject.onEffectLose = function(target, effect)
    local effectPower = effect:getPower()

    target:delMod(xi.mod.MEVA, effectPower * -3)
end

return effectObject
