-----------------------------------
--
--     tpz.effect.SUBTLE_SORCERY
--
-----------------------------------
-- Reduces the amount of enmity generated from magic spells and increases magic accuracy.
function onEffectGain(target, effect)
target:addMod(tpz.mod.MACC, 100)
end

function onEffectTick(target, effect)
target:addMod(tpz.mod.ENMITY, -20)
end

function onEffectLose(target, effect)
target:delMod(tpz.mod.MACC, 100)
target:delMod(tpz.mod.ENMITY)
end