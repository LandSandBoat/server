-----------------------------------
-- xi.effect.HAMANOHA
-----------------------------------
local effectObject = {}

effectObject.onEffectGain = function(target, effect)
    target:addMod(xi.mod.ACC, 20)
    target:addMod(xi.mod.EVA, 20)
    target:addMod(xi.mod.MACC, 20)
    target:addMod(xi.mod.MEVA, 20)
    target:addMod(xi.mod.REGAIN_DOWN, 20)
end

effectObject.onEffectTick = function(target, effect)
end

effectObject.onEffectLose = function(target, effect)
    target:delMod(xi.mod.ACC, 20)
    target:delMod(xi.mod.EVA, 20)
    target:delMod(xi.mod.MACC, 20)
    target:delMod(xi.mod.MEVA, 20)
    target:delMod(xi.mod.REGAIN_DOWN, 20)
end

return effectObject
