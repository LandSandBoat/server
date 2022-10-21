-----------------------------------
-- xi.effect.THRENODY
-- Reduces a targets given elemental resistance
-----------------------------------
local effectObject = {}

effectObject.onEffectGain = function(target, effect)
    target:addMod(effect:getSubPower(), effect:getPower())
end

effectObject.onEffectTick = function(target, effect)
end

effectObject.onEffectLose = function(target, effect)
    target:delMod(effect:getSubPower(), effect:getPower())
end

return effectObject
