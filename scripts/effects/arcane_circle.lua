-----------------------------------
-- xi.effect.ARCANE_CIRCLE
-----------------------------------
---@type TEffect
local effectObject = {}

effectObject.onEffectGain = function(target, effect)
    effect:addMod(xi.mod.ARCANA_KILLER, effect:getPower())
    effect:addMod(xi.mod.ARCANE_CIRCLE_DMG_BONUS, effect:getPower())
end

effectObject.onEffectTick = function(target, effect)
end

effectObject.onEffectLose = function(target, effect)
end

return effectObject
