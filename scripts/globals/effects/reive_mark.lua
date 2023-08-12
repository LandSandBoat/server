-----------------------------------
-- xi.effect.REIVE_MARK
-----------------------------------
local effectObject = {}

effectObject.onEffectGain = function(target, effect)
    if target:getPet() then
        target:getPet():addStatusEffect(effect)
    end
end

effectObject.onEffectTick = function(target, effect)
end

effectObject.onEffectLose = function(target, effect)
    if target:getPet() then
        target:getPet():delStatusEffect(xi.effect.REIVE_MARK)
    end
end

return effectObject
