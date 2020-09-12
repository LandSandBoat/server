-----------------------------------
--
--     tpz.effect.SACROSANCTITY
--
-----------------------------------

function onEffectGain(target, effect)
target:addMod(tpz.mod.MDEF, 75)
end

function onEffectTick(target, effect)
end

function onEffectLose(target, effect)
target:addMod(tpz.mod.MDEF, -75)
end