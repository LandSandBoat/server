-----------------------------------
--
--     tpz.effect.PERFECT_COUNTER
--
-----------------------------------

function onEffectGain(target, effect)
target:addMod(tpz.mod.PERFECT_COUNTER_ATT, 100)
end

function onEffectTick(target, effect)
end

function onEffectLose(target, effect)
target:addMod(tpz.mod.PERFECT_COUNTER_ATT, -100)
end