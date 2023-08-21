-----------------------------------
-- xi.effect.HUNDRED_FISTS
-----------------------------------
local effectObject = {}

effectObject.onEffectGain = function(target, effect)
    local jpLevel = target:getJobPointLevel(xi.jp.HUNDRED_FISTS_EFFECT)
    target:addMod(xi.mod.ACC, jpLevel * 2)
end

effectObject.onEffectTick = function(target, effect)
end

effectObject.onEffectLose = function(target, effect)
    local jpLevel = target:getJobPointLevel(xi.jp.HUNDRED_FISTS_EFFECT)
    target:delMod(xi.mod.ACC, jpLevel * 2)
end

return effectObject
