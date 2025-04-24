-----------------------------------
-- xi.effect.ARCANE_CIRCLE
-----------------------------------
---@type TEffect
local effectObject = {}

effectObject.onEffectGain = function(target, effect)
    target:addMod(xi.mod.ARCANA_KILLER, effect:getPower())
    target:addMod(xi.mod.ARCANE_CIRCLE_DMG_BONUS, effect:getPower())
end

effectObject.onEffectTick = function(target, effect)
end

effectObject.onEffectLose = function(target, effect)
    target:delMod(xi.mod.ARCANA_KILLER, effect:getPower())
    target:delMod(xi.mod.ARCANE_CIRCLE_DMG_BONUS, effect:getPower())
end

return effectObject
