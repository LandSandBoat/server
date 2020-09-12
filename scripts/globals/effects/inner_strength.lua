-----------------------------------
--
--     tpz.effect.INNER_STRENGTH
--
-----------------------------------

function onEffectGain(target, effect)
target:addMod(tpz.mod.HPP, 100)
target:addMod(tpz.mod.PERFECT_COUNTER_ATT, 100)
end

function onEffectTick(target, effect)
end

function onEffectLose(target, effect)
target:delMod(tpz.mod.HPP, 100)
target:addMod(tpz.mod.PERFECT_COUNTER_ATT, -100)
end
