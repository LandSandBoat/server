-----------------------------------
-- xi.effect.ARCANE_CIRCLE
-----------------------------------
local effectObject = {}

effectObject.onEffectGain = function(target, effect)
    effect:addMod(xi.mod.ARCANA_KILLER, effect:getPower())
end

effectObject.onEffectTick = function(target, effect)
end

effectObject.onEffectLose = function(target, effect)
end

return effectObject
