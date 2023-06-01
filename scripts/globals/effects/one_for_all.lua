-----------------------------------
-- xi.effect.ONE_FOR_ALL
-----------------------------------
local effectObject = {}

-- intentionally empty, effects of buff handled by using the power of the effect.
effectObject.onEffectGain = function(target, effect)
end

effectObject.onEffectTick = function(target, effect)
end

effectObject.onEffectLose = function(target, effect)
end

return effectObject
