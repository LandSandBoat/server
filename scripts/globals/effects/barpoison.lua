-----------------------------------
-- xi.effect.BARPOISON
-----------------------------------
local effectObject = {}

effectObject.onEffectGain = function(target, effect)
    target:addMod(xi.mod.POISON_MEVA, effect:getPower())
end

effectObject.onEffectTick = function(target, effect)
end

effectObject.onEffectLose = function(target, effect)
    target:delMod(xi.mod.POISON_MEVA, effect:getPower())
end

return effectObject
