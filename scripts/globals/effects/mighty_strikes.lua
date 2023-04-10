-----------------------------------
-- xi.effect.MIGHTY_STRIKES
-----------------------------------
require("scripts/globals/jobpoints")
require("scripts/globals/status")
-----------------------------------
local effectObject = {}

effectObject.onEffectGain = function(target, effect)
    local jpLevel = target:getJobPointLevel(xi.jp.MIGHTY_STRIKES_EFFECT)

    target:addMod(xi.mod.CRITHITRATE, 100)
    target:addMod(xi.mod.ACC, jpLevel * 2)
    target:addMod(xi.mod.RACC, jpLevel * 2)
end

effectObject.onEffectTick = function(target, effect)
end

effectObject.onEffectLose = function(target, effect)
    local jpLevel = target:getJobPointLevel(xi.jp.MIGHTY_STRIKES_EFFECT)

    target:addMod(xi.mod.CRITHITRATE, -100)
    target:delMod(xi.mod.ACC, jpLevel * 2)
    target:delMod(xi.mod.RACC, jpLevel * 2)
end

return effectObject
