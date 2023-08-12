-----------------------------------
-- xi.effect.SLUGGISH_DAZE_2
-----------------------------------
local effectObject = {}

effectObject.onEffectGain = function(target, effect)
    target:addMod(xi.mod.DEFP, -7)
end

effectObject.onEffectTick = function(target, effect)
end

effectObject.onEffectLose = function(target, effect)
    target:delMod(xi.mod.DEFP, -7)
end

return effectObject
