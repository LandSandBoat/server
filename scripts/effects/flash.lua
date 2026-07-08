-----------------------------------
-- xi.effect.FLASH
-----------------------------------
---@type TEffect
local effectObject = {}

-- Effect is handled in hit rate calculation
effectObject.onEffectGain = function(target, effect)
end

effectObject.onEffectTick = function(target, effect)
end

effectObject.onEffectLose = function(target, effect)
end

return effectObject
