-----------------------------------
-- xi.effect.SEPULCHER
-----------------------------------
local effect_object = {}

effect_object.onEffectGain = function(target, effect)
    local power = -effect:getPower()

    target:addMod(xi.mod.ACC, power)
    target:addMod(xi.mod.EVA, power)
    target:addMod(xi.mod.MACC, power)
    target:addMod(xi.mod.MEVA, power)
    target:addMod(xi.mod.STORETP, power)
end

effect_object.onEffectTick = function(target, effect)
end

effect_object.onEffectLose = function(target, effect)
    local power = -effect:getPower()

    target:delMod(xi.mod.ACC, power)
    target:delMod(xi.mod.EVA, power)
    target:delMod(xi.mod.MACC, power)
    target:delMod(xi.mod.MEVA, power)
    target:delMod(xi.mod.STORETP, power)
end

return effect_object
