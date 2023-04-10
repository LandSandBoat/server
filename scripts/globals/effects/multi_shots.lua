-----------------------------------
-- xi.effect.MULTI_SHOTS
-----------------------------------
local effectObject = {}

effectObject.onEffectGain = function(target, effect)
    target:addMod(xi.mod.DOUBLE_SHOT_RATE, effect:getPower())
end

effectObject.onEffectTick = function(target, effect)
end

effectObject.onEffectLose = function(target, effect)
    target:delMod(xi.mod.DOUBLE_SHOT_RATE, effect:getPower())
end

return effectObject
