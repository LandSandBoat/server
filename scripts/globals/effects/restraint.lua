-----------------------------------
-- xi.effect.RESTRAINT
-----------------------------------
local effectObject = {}

effectObject.onEffectGain = function(target, effect)
end

effectObject.onEffectTick = function(target, effect)
end

effectObject.onEffectLose = function(target, effect)
    local power = effect:getPower()

    target:delMod(xi.mod.ALL_WSDMG_FIRST_HIT, power)
end

return effectObject
