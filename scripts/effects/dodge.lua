-----------------------------------
-- xi.effect.DODGE
-----------------------------------
local effectObject = {}

effectObject.onEffectGain = function(target, effect)
    local jpLevel = target:getJobPointLevel(xi.jp.DODGE_EFFECT) * 2
    target:addMod(xi.mod.EVA, effect:getPower() + jpLevel)
end

effectObject.onEffectTick = function(target, effect)
end

effectObject.onEffectLose = function(target, effect)
    local jpLevel = target:getJobPointLevel(xi.jp.DODGE_EFFECT) * 2
    target:delMod(xi.mod.EVA, effect:getPower() + jpLevel)
end

return effectObject
