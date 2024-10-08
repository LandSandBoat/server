-----------------------------------
-- xi.effect.HASSO
-- Straight +10% haste +10 Acc and scaling (lv) STR
-- also -50% FC
-----------------------------------
---@type TEffect
local effectObject = {}

effectObject.onEffectGain = function(target, effect)
    target:addMod(xi.mod.TWOHAND_STR, effect:getPower())
    target:addMod(xi.mod.TWOHAND_HASTE_ABILITY, 1000)
    target:addMod(xi.mod.TWOHAND_ACC, 10)
end

effectObject.onEffectTick = function(target, effect)
end

effectObject.onEffectLose = function(target, effect)
    target:delMod(xi.mod.TWOHAND_STR, effect:getPower())
    target:delMod(xi.mod.TWOHAND_HASTE_ABILITY, 1000)
    target:delMod(xi.mod.TWOHAND_ACC, 10)
end

return effectObject
