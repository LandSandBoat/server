-----------------------------------
-- xi.effect.BOLSTER
-----------------------------------
local effectObject = {}

effectObject.onEffectGain = function(target, effect)
    xi.job_utils.geomancer.bolsterOnEffectGain(target, effect)
end

effectObject.onEffectTick = function(target, effect)
end

effectObject.onEffectLose = function(target, effect)
    xi.job_utils.geomancer.bolsterOnEffectLose(target, effect)
end

return effectObject
