-----------------------------------
-- xi.effect.NATURALISTS_ROLL
-----------------------------------
local effectObject = {}

effectObject.onEffectGain = function(target, effect)
    target:addMod(xi.mod.ENH_MAGIC_DURATION, effect:getPower())
end

effectObject.onEffectTick = function(target, effect)
end

effectObject.onEffectLose = function(target, effect)
    target:delMod(xi.mod.ENH_MAGIC_DURATION, effect:getPower())
end

return effectObject
