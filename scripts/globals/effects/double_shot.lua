-----------------------------------
-- xi.effect.DOUBLE_SHOT
-----------------------------------
require("scripts/globals/jobpoints")
require("scripts/globals/status")
-----------------------------------
local effectObject = {}

effectObject.onEffectGain = function(target, effect)
    local jpValue = target:getJobPointLevel(xi.jp.DOUBLE_SHOT_EFFECT)

    target:addMod(xi.mod.DOUBLE_SHOT_RATE, effect:getPower() + jpValue)
end

effectObject.onEffectTick = function(target, effect)
end

effectObject.onEffectLose = function(target, effect)
    local jpValue = target:getJobPointLevel(xi.jp.DOUBLE_SHOT_EFFECT)

    target:delMod(xi.mod.DOUBLE_SHOT_RATE, effect:getPower() + jpValue)
end

return effectObject
