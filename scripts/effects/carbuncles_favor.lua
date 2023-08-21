-----------------------------------
-- xi.effect.CARBUNCLES_FAVOR
-----------------------------------

local effectObject = {}

effectObject.onEffectGain = function(target, effect)
    target:addMod(xi.mod.REGEN, effect:getPower())
end

effectObject.onEffectTick = function(target, effect)
end

effectObject.onEffectLose = function(target, effect)
    target:delMod(xi.mod.REGEN, effect:getPower())
end

return effectObject
