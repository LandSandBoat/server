-----------------------------------
-- xi.effect.FOCUS
-----------------------------------
local effectObject = {}

effectObject.onEffectGain = function(target, effect)
    local jpLevel = target:getJobPointLevel(xi.jp.FOCUS_EFFECT)
    target:addMod(xi.mod.ACC, effect:getPower() + jpLevel)
end

effectObject.onEffectTick = function(target, effect)
end

effectObject.onEffectLose = function(target, effect)
    local jpLevel = target:getJobPointLevel(xi.jp.FOCUS_EFFECT)
    target:delMod(xi.mod.ACC, effect:getPower() + jpLevel)
end

return effectObject
