-----------------------------------
-- xi.effect.COOKING_IMAGERY
-----------------------------------
local effectObject = {}

effectObject.onEffectGain = function(target, effect)
    target:addMod(xi.mod.COOK, effect:getPower())
end

effectObject.onEffectTick = function(target, effect)
end

effectObject.onEffectLose = function(target, effect)
    target:delMod(xi.mod.COOK, effect:getPower())
end

return effectObject
