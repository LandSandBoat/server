-----------------------------------
-- xi.effect.BEWILDERED_DAZE_4
-----------------------------------
local effectObject = {}

effectObject.onEffectGain = function(target, effect)
    target:addMod(xi.mod.CEVA, -11)
end

effectObject.onEffectTick = function(target, effect)
end

effectObject.onEffectLose = function(target, effect)
    target:delMod(xi.mod.CEVA, -11)
end

return effectObject
