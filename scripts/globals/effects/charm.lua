-----------------------------------
--
--
--
-----------------------------------

function onEffectGain(target, effect)
end

function onEffectTick(target, effect)
end

function onEffectLose(target, effect)
    target:setTP(0)
    target:uncharm()
end
