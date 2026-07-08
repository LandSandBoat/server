-----------------------------------
-- xi.effect.ANCIENT_CIRCLE
-----------------------------------
---@type TEffect
local effectObject = {}

effectObject.onEffectGain = function(target, effect)
    local jpValue = target:getJobPointLevel(xi.jp.ANCIENT_CIRCLE_EFFECT) -- Only affects damage recieved.

    effect:addMod(xi.mod.DRAGON_KILLER, effect:getPower())
    effect:addMod(xi.mod.DRAGON_DMG_MULTIPLIER, effect:getPower())
    effect:addMod(xi.mod.DRAGON_RES_MULTIPLIER, effect:getPower() + jpValue)
end

effectObject.onEffectTick = function(target, effect)
end

effectObject.onEffectLose = function(target, effect)
end

return effectObject
