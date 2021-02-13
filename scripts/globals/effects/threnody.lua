-----------------------------------
-- tpz.effect.THRENODY
-- Reduces a targets given elemental resistance
-----------------------------------
local effect_object = {}

effect_object.onEffectGain = function(target, effect)
    target:addMod(effect:getSubPower(), effect:getPower())
end

effect_object.onEffectTick = function(target, effect)
end

effect_object.onEffectLose = function(target, effect)
    target:delMod(effect:getSubPower(), effect:getPower())
end

return effect_object
