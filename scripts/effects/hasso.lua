-----------------------------------
-- xi.effect.HASSO
-- Straight +10% haste +10 Acc and scaling (lv) STR
-- also -50% FC
-----------------------------------
---@type TEffect
local effectObject = {}

effectObject.onEffectGain = function(target, effect)
    effect:addMod(xi.mod.TWOHAND_STR, effect:getPower())
    effect:addMod(xi.mod.TWOHAND_HASTE_ABILITY, 1000)
    effect:addMod(xi.mod.TWOHAND_ACC, 10)
end

effectObject.onEffectTick = function(target, effect)
end

effectObject.onEffectLose = function(target, effect)
end

return effectObject
