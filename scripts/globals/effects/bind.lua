-----------------------------------
-- xi.effect.BIND
-----------------------------------
local effectObject = {}

effectObject.onEffectGain = function(target, effect)
    effect:setPower(target:getSpeed())
    target:setSpeed(0)
end

effectObject.onEffectTick = function(target, effect)
end

effectObject.onEffectLose = function(target, effect)
    target:setSpeed(effect:getPower())
end

return effectObject
