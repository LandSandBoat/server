----------------------------------------
-- tpz.effect.HAMANOHA
----------------------------------------
local effect_object = {}

effect_object.onEffectGain = function(target, effect)
    target:addMod(tpz.mod.ACC, 20)
    target:addMod(tpz.mod.EVA, 20)
    target:addMod(tpz.mod.MACC, 20)
    target:addMod(tpz.mod.MEVA, 20)
    target:addMod(tpz.mod.REGAIN_DOWN, 20)
end

effect_object.onEffectTick = function(target, effect)
end

effect_object.onEffectLose = function(target, effect)
    target:delMod(tpz.mod.ACC, 20)
    target:delMod(tpz.mod.EVA, 20)
    target:delMod(tpz.mod.MACC, 20)
    target:delMod(tpz.mod.MEVA, 20)
    target:delMod(tpz.mod.REGAIN_DOWN, 20)
end

return effect_object
