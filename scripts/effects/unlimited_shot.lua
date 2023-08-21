-----------------------------------
-- xi.effect.UNLIMITED_SHOT
-----------------------------------
local effectObject = {}

effectObject.onEffectGain = function(target, effect)
    local jpValue = target:getJobPointLevel(xi.jp.UNLIMITED_SHOT_EFFECT)

    target:addMod(xi.mod.ENMITY, -2 * jpValue)
end

effectObject.onEffectTick = function(target, effect)
end

effectObject.onEffectLose = function(target, effect)
    local jpValue = target:getJobPointLevel(xi.jp.UNLIMITED_SHOT_EFFECT)

    target:delMod(xi.mod.ENMITY, -2 * jpValue)
end

return effectObject
