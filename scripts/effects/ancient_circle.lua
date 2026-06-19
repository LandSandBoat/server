-----------------------------------
-- xi.effect.ANCIENT_CIRCLE
-----------------------------------
---@type TEffect
local effectObject = {}

effectObject.onEffectGain = function(target, effect)
    effect:addMod(xi.mod.DRAGON_KILLER, effect:getPower())
    effect:addMod(xi.mod.ANCIENT_CIRCLE_DMG_BONUS, effect:getPower())
end

effectObject.onEffectTick = function(target, effect)
end

effectObject.onEffectLose = function(target, effect)
end

return effectObject
