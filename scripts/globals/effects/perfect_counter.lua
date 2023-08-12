-----------------------------------
-- xi.effect.PERFECT_COUNTER
-----------------------------------
local effectObject = {}

effectObject.onEffectGain = function(target, effect)
    target:addMod(xi.mod.PERFECT_COUNTER_ATT, 100)
end

effectObject.onEffectTick = function(target, effect)
end

effectObject.onEffectLose = function(target, effect)
    target:delMod(xi.mod.PERFECT_COUNTER_ATT, 100)
end

return effectObject
