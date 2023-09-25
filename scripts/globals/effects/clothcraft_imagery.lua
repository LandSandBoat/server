-----------------------------------
-- xi.effect.CLOTHCRAFT_IMAGERY
-----------------------------------
local effectObject = {}

effectObject.onEffectGain = function(target, effect)
    target:addMod(xi.mod.CLOTH, effect:getPower())
end

effectObject.onEffectTick = function(target, effect)
end

effectObject.onEffectLose = function(target, effect)
    target:delMod(xi.mod.CLOTH, effect:getPower())
end

return effectObject
