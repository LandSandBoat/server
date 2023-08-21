-----------------------------------
-- xi.effect.AFTERMATH
-----------------------------------
local effectObject = {}

effectObject.onEffectGain = function(target, effect)
    xi.aftermath.onEffectGain(target, effect)
end

effectObject.onEffectTick = function(target, effect)
end

effectObject.onEffectLose = function(target, effect)
    xi.aftermath.onEffectLose(target, effect)
end

return effectObject
