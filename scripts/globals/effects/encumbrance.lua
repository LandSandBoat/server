-----------------------------------
--
--
--
-----------------------------------

function onEffectGain(target, effect)
    target:setEquipBlock(effect:getPower())
end

function onEffectTick(target, effect)
end

function onEffectLose(target, effect)
    target:setEquipBlock(0)
end
