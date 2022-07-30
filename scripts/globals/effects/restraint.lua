-----------------------------------
-- xi.effect.RESTRAINT
-----------------------------------
local effect_object = {}

effect_object.onEffectGain = function(target, effect)
end

effect_object.onEffectTick = function(target, effect)
end

effect_object.onEffectLose = function(target, effect)
    local power = effect:getPower()

    target:delMod(xi.mod.ALL_WSDMG_FIRST_HIT, power)
end

return effect_object
