-----------------------------------
-- xi.effect.ARCANE_CREST
-----------------------------------
local effectObject = {}

effectObject.onEffectGain = function(target, effect)
    local power = -effect:getPower()

    effect:addMod(xi.mod.ACC, power)
    effect:addMod(xi.mod.EVA, power)
    effect:addMod(xi.mod.MACC, power)
    effect:addMod(xi.mod.MEVA, power)
    effect:addMod(xi.mod.STORETP, power)
end

effectObject.onEffectTick = function(target, effect)
end

effectObject.onEffectLose = function(target, effect)
end

return effectObject
