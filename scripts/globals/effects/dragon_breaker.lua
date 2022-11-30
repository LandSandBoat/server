-----------------------------------
-- xi.effect.DRAGON_BREAKER
-----------------------------------
local effectObject = {}

-- This is a debuff, delMod on gain
effectObject.onEffectGain = function(target, effect)
    local power = effect:getPower()

    target:delMod(xi.mod.ACC, power)
    target:delMod(xi.mod.EVA, power)
    target:delMod(xi.mod.MACC, power)
    target:delMod(xi.mod.MEVA, power)
    target:delMod(xi.mod.STORETP, power)
end

effectObject.onEffectTick = function(target, effect)
end

effectObject.onEffectLose = function(target, effect)
    local power = effect:getPower()

    target:addMod(xi.mod.ACC, power)
    target:addMod(xi.mod.EVA, power)
    target:addMod(xi.mod.MACC, power)
    target:addMod(xi.mod.MEVA, power)
    target:addMod(xi.mod.STORETP, power)
end

return effectObject
