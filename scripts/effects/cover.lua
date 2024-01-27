-----------------------------------
-- xi.mod.COVER_EFFECT
-----------------------------------
local effectObject = {}

effectObject.onEffectGain = function(target, effect)
end

effectObject.onEffectTick = function(target, effect)
end

effectObject.onEffectLose = function(target, effect)
    target:setLocalVar('COVER_ABILITY_TARGET', 0)
end

return effectObject
