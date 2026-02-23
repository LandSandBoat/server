-----------------------------------
-- xi.effect.CAMOUFLAGE
-----------------------------------
---@type TEffect
local effectObject = {}

effectObject.onEffectGain = function(target, effect)
    local jpValue = target:getJobPointLevel(xi.jp.CAMOUFLAGE_EFFECT)

    effect:addMod(xi.mod.ENMITY, -25)
    effect:addMod(xi.mod.CRITHITRATE, jpValue)
    effect:addMod(xi.mod.RETAIN_CAMOUFLAGE, 1)
end

effectObject.onEffectTick = function(target, effect)
end

effectObject.onEffectLose = function(target, effect)
end

return effectObject
