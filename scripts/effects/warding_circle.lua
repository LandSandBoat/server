-----------------------------------
-- xi.effect.WARDING_CIRCLE
-----------------------------------
---@type TEffect
local effectObject = {}

effectObject.onEffectGain = function(target, effect)
    local jpValue = target:getJobPointLevel(xi.jp.WARDING_CIRCLE_EFFECT)

    effect:addMod(xi.mod.DEMON_KILLER, effect:getPower() + jpValue)
    effect:addMod(xi.mod.WARDING_CIRCLE_DMG_BONUS, effect:getPower())
end

effectObject.onEffectTick = function(target, effect)
end

effectObject.onEffectLose = function(target, effect)
end

return effectObject
