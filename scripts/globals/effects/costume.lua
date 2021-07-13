-----------------------------------
-- xi.effect.COSTUME
-----------------------------------
local effect_object = {}

effect_object.onEffectGain = function(target, effect)
    target:setCostume(effect:getPower())
end

effect_object.onEffectTick = function(target, effect)
end

effect_object.onEffectLose = function(target, effect)
    target:setCostume(0)
end

return effect_object
