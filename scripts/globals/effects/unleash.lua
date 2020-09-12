-----------------------------------
--
--     tpz.effect.UNLEASH
--
-----------------------------------

function onEffectGain(target, effect)
target:addMod(tpz.mod.TAME, 98)
end

function onEffectTick(target, effect)
end

function onEffectLose(target, effect)
target:delMod(tpz.mod.TAME, 98)
end