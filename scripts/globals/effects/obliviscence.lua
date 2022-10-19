-----------------------------------
-- xi.effect.OBLIVISCENCE
-----------------------------------
local effectObject = {}

effectObject.onEffectGain = function(target, effect)
    target:recalculateStats()
end

effectObject.onEffectTick = function(target, effect)
end

effectObject.onEffectLose = function(target, effect)
    target:recalculateStats()
end

return effectObject
