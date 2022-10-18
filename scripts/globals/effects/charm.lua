-----------------------------------
-- xi.effect.CHARM
-----------------------------------
local effectObject = {}

effectObject.onEffectGain = function(target, effect)
end

effectObject.onEffectTick = function(target, effect)
end

effectObject.onEffectLose = function(target, effect)
    target:setTP(0)
    target:uncharm()
end

return effectObject
