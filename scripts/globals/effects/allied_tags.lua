-----------------------------------
--
--
--
-----------------------------------

function onEffectGain(target, effect)
    if (target:getPet()) then
        target:getPet():addStatusEffect(effect)
    end
end

function onEffectTick(target, effect)
end

function onEffectLose(target, effect)
    if (target:getPet()) then
        target:getPet():delStatusEffect(tpz.effect.ALLIED_TAGS)
    end
end
