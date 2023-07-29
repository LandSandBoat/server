-----------------------------------
-- xi.effect.BARSILENCE
-----------------------------------
local effectObject = {}

effectObject.onEffectGain = function(target, effect)
    target:addMod(xi.mod.SILENCE_MEVA, effect:getPower())
end

effectObject.onEffectTick = function(target, effect)
end

effectObject.onEffectLose = function(target, effect)
    target:delMod(xi.mod.SILENCE_MEVA, effect:getPower())
end

return effectObject
