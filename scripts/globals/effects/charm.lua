-----------------------------------
-- tpz.effect.CHARM
-----------------------------------
local effect_object = {}

effect_object.onEffectGain = function(target, effect)
end

effect_object.onEffectTick = function(target, effect)
end

effect_object.onEffectLose = function(target, effect)
    target:setTP(0)
    target:uncharm()
end

return effect_object
