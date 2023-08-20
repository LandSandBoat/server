-----------------------------------
-- xi.effect.BARBLIND
-----------------------------------
local effectObject = {}

effectObject.onEffectGain = function(target, effect)
    target:addMod(xi.mod.BLIND_MEVA, effect:getPower())
end

effectObject.onEffectTick = function(target, effect)
end

effectObject.onEffectLose = function(target, effect)
    target:delMod(xi.mod.BLIND_MEVA, effect:getPower())
end

return effectObject
