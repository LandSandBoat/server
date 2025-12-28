-----------------------------------
-- xi.effect.SUBLIMATION_COMPLETE
-----------------------------------
---@type TEffect
local effectObject = {}

effectObject.onEffectGain = function(target, effect)
    target:delStatusEffect(xi.effect.REFRESH)
end

effectObject.onEffectTick = function(target, effect)
end

effectObject.onEffectLose = function(target, effect)
end

return effectObject
