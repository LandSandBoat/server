-----------------------------------
--
--     tpz.effect.LEVEL_SYNC
--
-----------------------------------

function onEffectGain(target, effect)
    target:levelRestriction(effect:getPower())
end

function onEffectTick(target, effect)
end

function onEffectLose(target, effect)
    target:levelRestriction(0)
    target:disableLevelSync()
end
