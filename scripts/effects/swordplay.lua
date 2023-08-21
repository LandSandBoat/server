-----------------------------------
-- xi.effect.SWORDPLAY
-----------------------------------
local effectObject = {}

effectObject.onEffectGain = function(target, effect)
    xi.job_utils.rune_fencer.onSwordplayEffectGain(target, effect)
end

effectObject.onEffectTick = function(target, effect)
    xi.job_utils.rune_fencer.onSwordplayEffectTick(target, effect)
end

effectObject.onEffectLose = function(target, effect)
    xi.job_utils.rune_fencer.onSwordplayEffectLose(target, effect)
end

return effectObject
