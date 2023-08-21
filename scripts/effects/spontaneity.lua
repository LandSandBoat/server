-----------------------------------
-- xi.effect.SPONTANEITY
-----------------------------------
local effectObject = {}

effectObject.onEffectGain = function(target, effect)
    target:addMod(xi.mod.UFASTCAST, 150)
    effect:addEffectFlag(xi.effectFlag.MAGIC_BEGIN)
end

effectObject.onEffectTick = function(target, effect)
end

effectObject.onEffectLose = function(target, effect)
    target:delMod(xi.mod.UFASTCAST, 150)
end

return effectObject
