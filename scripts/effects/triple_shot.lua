-----------------------------------
-- xi.effect.TRIPLE_SHOT
-----------------------------------
local effectObject = {}

effectObject.onEffectGain = function(target, effect)
    local jpValue = target:getJobPointLevel(xi.jp.TRIPLE_SHOT_EFFECT)

    target:addMod(xi.mod.TRIPLE_SHOT_RATE, effect:getPower() + jpValue)
end

effectObject.onEffectTick = function(target, effect)
end

effectObject.onEffectLose = function(target, effect)
    local jpValue = target:getJobPointLevel(xi.jp.TRIPLE_SHOT_EFFECT)

    target:delMod(xi.mod.TRIPLE_SHOT_RATE, effect:getPower() + jpValue)
end

return effectObject
