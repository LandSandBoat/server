-----------------------------------
-- xi.effect.HASSO
-- Straight +10% haste +10 Acc and scaling (lv) STR
-- also -50% FC
-----------------------------------
local effectObject = {}

effectObject.onEffectGain = function(target, effect)
    target:addMod(xi.mod.STR, effect:getPower())
    target:addMod(xi.mod.HASTE_ABILITY, 1000)
    target:addMod(xi.mod.ACC, 10)
end

effectObject.onEffectTick = function(target, effect)
end

effectObject.onEffectLose = function(target, effect)
    target:delMod(xi.mod.STR, effect:getPower())
    target:delMod(xi.mod.HASTE_ABILITY, 1000)
    target:delMod(xi.mod.ACC, 10)
end

return effectObject
