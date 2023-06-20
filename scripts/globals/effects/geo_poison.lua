-----------------------------------
-- xi.effect.GEO_POISON
-----------------------------------
local effectObject = {}

effectObject.onEffectGain = function(target, effect)
    target:addMod(xi.mod.REGEN_DOWN, effect:getPower())
end

effectObject.onEffectTick = function(target, effect)
end

effectObject.onEffectLose = function(target, effect)
    target:delMod(xi.mod.REGEN_DOWN, effect:getPower())
end

return effectObject
