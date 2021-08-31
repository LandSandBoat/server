-----------------------------------
-- xi.effect.OBLIVISCENCE
-----------------------------------
local effect_object = {}

effect_object.onEffectGain = function(target, effect)
    target:recalculateStats()
end

effect_object.onEffectTick = function(target, effect)
end

effect_object.onEffectLose = function(target, effect)
    target:recalculateStats()
end

return effect_object
