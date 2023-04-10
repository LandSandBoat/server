-----------------------------------
-- xi.effect.CAMOUFLAGE
-----------------------------------
require("scripts/globals/jobpoints")
require("scripts/globals/status")
-----------------------------------
local effectObject = {}

effectObject.onEffectGain = function(target, effect)
    local jpValue = target:getJobPointLevel(xi.jp.CAMOUFLAGE_EFFECT)

    target:addMod(xi.mod.ENMITY, -25)
    target:addMod(xi.mod.CRITHITRATE, jpValue)
end

effectObject.onEffectTick = function(target, effect)
end

effectObject.onEffectLose = function(target, effect)
    local jpValue = target:getJobPointLevel(xi.jp.CAMOUFLAGE_EFFECT)

    target:delMod(xi.mod.ENMITY, -25)
    target:delMod(xi.mod.CRITHITRATE, jpValue)
end

return effectObject
