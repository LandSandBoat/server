-----------------------------------
-- xi.effect.SACROSANCTITY
-----------------------------------
local effectObject = {}

effectObject.onEffectGain = function(target, effect)
    target:addMod(xi.mod.MDEF, 75)
end

effectObject.onEffectTick = function(target, effect)
end

effectObject.onEffectLose = function(target, effect)
    target:delMod(xi.mod.MDEF, 75)
end

return effectObject
