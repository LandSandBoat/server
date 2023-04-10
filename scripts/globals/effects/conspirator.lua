-----------------------------------
-- xi.effect.CONSPIRATOR
-----------------------------------
require("scripts/globals/jobpoints")
require("scripts/globals/status")
-----------------------------------
local effectObject = {}

effectObject.onEffectGain = function(target, effect)
    local jpValue = target:getJobPointLevel(xi.jp.CONSPIRATOR_EFFECT)

    target:addMod(xi.mod.SUBTLE_BLOW, effect:getPower())
    target:addMod(xi.mod.ACC, effect:getSubPower() + jpValue)
end

effectObject.onEffectTick = function(target, effect)
end

effectObject.onEffectLose = function(target, effect)
    local jpValue = target:getJobPointLevel(xi.jp.CONSPIRATOR_EFFECT)

    target:delMod(xi.mod.SUBTLE_BLOW, effect:getPower())
    target:delMod(xi.mod.ACC, effect:getSubPower() + jpValue)
end

return effectObject
