-----------------------------------
-- xi.effect.BARSLEEP
-----------------------------------
local effectObject = {}

effectObject.onEffectGain = function(target, effect)
    target:addMod(xi.mod.SLEEP_MEVA, effect:getPower())
end

effectObject.onEffectTick = function(target, effect)
end

effectObject.onEffectLose = function(target, effect)
    target:delMod(xi.mod.SLEEP_MEVA, effect:getPower())
end

return effectObject
