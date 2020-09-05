-----------------------------------
--
--
--
-----------------------------------

function onEffectGain(target, effect)
    target:recalculateStats()
end

function onEffectTick(target, effect)
end

function onEffectLose(target, effect)
    target:recalculateStats()
end
