-----------------------------------
-- xi.effect.LETHARGIC_DAZE_5
-----------------------------------
local effectObject = {}

effectObject.onEffectGain = function(target, effect)
    target:addMod(xi.mod.EVA, -24)
end

effectObject.onEffectTick = function(target, effect)
end

effectObject.onEffectLose = function(target, effect)
    target:delMod(xi.mod.EVA, -24)
end

return effectObject
