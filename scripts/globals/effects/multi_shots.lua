-----------------------------------
-- xi.effect.MULTI_SHOTS
-----------------------------------
local effect_object = {}

effect_object.onEffectGain = function(target, effect)
    target:addMod(xi.mod.DOUBLE_SHOT_RATE, effect:getPower())
end

effect_object.onEffectTick = function(target, effect)
end

effect_object.onEffectLose = function(target, effect)
    target:delMod(xi.mod.DOUBLE_SHOT_RATE, effect:getPower())
end

return effect_object
