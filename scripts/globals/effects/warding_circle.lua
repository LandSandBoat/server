-----------------------------------
-- xi.effect.WARDING_CIRCLE
-----------------------------------
require("scripts/globals/jobpoints")
require("scripts/globals/status")
-----------------------------------
local effectObject = {}

effectObject.onEffectGain = function(target, effect)
    local jpValue = target:getJobPointLevel(xi.jp.WARDING_CIRCLE_EFFECT)

    target:addMod(xi.mod.DEMON_KILLER, effect:getPower() + jpValue)
end

effectObject.onEffectTick = function(target, effect)
end

effectObject.onEffectLose = function(target, effect)
    local jpValue = target:getJobPointLevel(xi.jp.WARDING_CIRCLE_EFFECT)

    target:delMod(xi.mod.DEMON_KILLER, effect:getPower() + jpValue)
end

return effectObject
