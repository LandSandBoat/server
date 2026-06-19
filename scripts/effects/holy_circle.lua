-----------------------------------
-- xi.effect.HOLY_CIRCLE
-----------------------------------
---@type TEffect
local effectObject = {}

effectObject.onEffectGain = function(target, effect)
    effect:addMod(xi.mod.UNDEAD_KILLER, effect:getPower())
    effect:addMod(xi.mod.HOLY_CIRCLE_DMG_BONUS, effect:getPower())
end

effectObject.onEffectTick = function(target, effect)
end

effectObject.onEffectLose = function(target, effect)
end

return effectObject
