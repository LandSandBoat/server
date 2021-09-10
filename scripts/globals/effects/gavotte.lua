-----------------------------------
-- xi.effect.GAVOTTE
-----------------------------------
local effect_object = {}

effect_object.onEffectGain = function(target, effect)
    target:addMod(xi.mod.BINDRES, effect:getPower())
end

effect_object.onEffectTick = function(target, effect)
end

effect_object.onEffectLose = function(target, effect)
    target:delMod(xi.mod.BINDRES, effect:getPower())
end

return effect_object
