-----------------------------------
-- xi.effect.UNBRIDLED_LEARNING
-- ERA custom xi.events.skillUp campaign
-----------------------------------
---@type TEffect
local effectObject = {}

effectObject.onEffectGain = function(target, effect)
    xi.events.skillUp.onEffectGain(target, effect)
end

effectObject.onEffectTick = function(target, effect)
end

effectObject.onEffectLose = function(target, effect)
    xi.events.skillUp.onEffectLose(target, effect)
end

return effectObject
