-----------------------------------
-- xi.effect.CURING_CONDUIT
-----------------------------------
local effectObject = {}

effectObject.onEffectGain = function(target, effect)
    target:addMod(xi.mod.CURE_POTENCY_RCVD, effect:getPower())
end

effectObject.onEffectTick = function(target, effect)
end

effectObject.onEffectLose = function(target, effect)
    target:delMod(xi.mod.CURE_POTENCY_RCVD, effect:getPower())
end

return effectObject
