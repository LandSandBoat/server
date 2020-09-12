-----------------------------------
--
--
--
-----------------------------------

function onEffectGain(target, effect)
target:addMod(tpz.mod.TRIPLE_ATTACK, 100)
end

function onEffectTick(target, effect)
end

function onEffectLose(target, effect)
target:addMod(tpz.mod.TRIPLE_ATTACK, -100)
end
