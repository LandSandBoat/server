-----------------------------------
-- xi.effect.GALLANTS_ROLL
-----------------------------------
local effectObject = {}

effectObject.onEffectGain = function(target, effect)
    target:addMod(xi.mod.DMG, -effect:getPower())
end

effectObject.onEffectTick = function(target, effect)
end

effectObject.onEffectLose = function(target, effect)
    target:delMod(xi.mod.DMG, -effect:getPower())
end

return effectObject
