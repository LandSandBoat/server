-----------------------------------
-- xi.effect.PERFECT_DODGE
-----------------------------------
require("scripts/globals/jobpoints")
require("scripts/globals/status")
-----------------------------------
local effectObject = {}

effectObject.onEffectGain = function(target, effect)
    local jpValue = target:getJobPointLevel(xi.jp.PERFECT_DODGE_EFFECT)
    target:addMod(xi.mod.MEVA, jpValue * 3)
end

effectObject.onEffectTick = function(target, effect)
end

effectObject.onEffectLose = function(target, effect)
    local jpValue = target:getJobPointLevel(xi.jp.PERFECT_DODGE_EFFECT)
    target:delMod(xi.mod.MEVA, jpValue * 3)
end

return effectObject
