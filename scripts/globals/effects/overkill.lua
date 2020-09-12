-----------------------------------
--
--     tpz.effect.OVERKILL
--     
-----------------------------------

function onEffectGain(target, effect)
target:addMod(tpz.mod.DOUBLE_SHOT_RATE, 100)
target:addMod(tpz.mod.TRIPLE_ATTACK, 33)
end

function onEffectTick(target, effect)
end

function onEffectLose(target, effect)
target:delMod(tpz.mod.DOUBLE_SHOT_RATE, 100)
target:delMod(tpz.mod.TRIPLE_ATTACK, 33)
end