-----------------------------------
-- xi.effect.COSTUME
-----------------------------------
local effectObject = {}

effectObject.onEffectGain = function(target, effect)
    target:setCostume(effect:getPower())
end

effectObject.onEffectTick = function(target, effect)
end

effectObject.onEffectLose = function(target, effect)
    target:setCostume(0)
end

return effectObject
