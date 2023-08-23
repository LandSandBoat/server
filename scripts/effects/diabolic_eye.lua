-----------------------------------
-- xi.effect.DIABOLIC_EYE
-----------------------------------
local effectObject = {}

effectObject.onEffectGain = function(target, effect)
    target:addMod(xi.mod.ACC, 15 + effect:getPower())
    target:addMod(xi.mod.HPP, -15)
end

effectObject.onEffectTick = function(target, effect)
end

effectObject.onEffectLose = function(target, effect)
    target:delMod(xi.mod.ACC, 15 + effect:getPower())
    target:delMod(xi.mod.HPP, -15)
end

return effectObject
