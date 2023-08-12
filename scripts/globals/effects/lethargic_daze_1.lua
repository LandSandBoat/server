-----------------------------------
-- xi.effect.LETHARGIC_DAZE_1
-----------------------------------
local effectObject = {}

effectObject.onEffectGain = function(target, effect)
    local effectPower = effect:getPower()

    target:addMod(xi.mod.EVA, (effectPower + 1) * -4)
end

effectObject.onEffectTick = function(target, effect)
end

effectObject.onEffectLose = function(target, effect)
    local effectPower = effect:getPower()

    target:delMod(xi.mod.EVA, (effectPower + 1) * -4)
end

return effectObject
