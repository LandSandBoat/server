-----------------------------------
-- xi.effect.UNLIMITED_SHOT
-----------------------------------
---@type TEffect
local effectObject = {}

effectObject.onEffectGain = function(target, effect)
    local jpValue = target:getJobPointLevel(xi.jp.UNLIMITED_SHOT_EFFECT)

    effect:addMod(xi.mod.ENMITY, -2 * jpValue)
    effect:addMod(xi.mod.RETAIN_UNLIMITED_SHOT, 1)
end

effectObject.onEffectTick = function(target, effect)
end

effectObject.onEffectLose = function(target, effect)
end

return effectObject
