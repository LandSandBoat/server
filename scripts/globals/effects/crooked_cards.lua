-----------------------------------
--
--     tpz.effect.CROOKED_CARDS	
--
-----------------------------------

function onEffectGain(target, effect)
target:addMod(tpz.mod.PHANTOM_ROLL, 100)
end

function onEffectTick(target, effect)
end

function onEffectLose(target, effect)
target:delMod(tpz.mod.PHANTOM_ROLL, 100)
end
