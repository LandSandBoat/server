-----------------------------------
-- xi.effect.HASSO
-- Straight +10% haste +10 Acc and scaling (lv) STR
-- also -50% FC
-----------------------------------
require("scripts/globals/status")
-----------------------------------
local effect_object = {}

effect_object.onEffectGain = function(target, effect)
    target:addMod(xi.mod.STR, effect:getPower())
    target:addMod(xi.mod.HASTE_ABILITY, 1000)
    target:addMod(xi.mod.ACC, 10)
end

effect_object.onEffectTick = function(target, effect)
end

effect_object.onEffectLose = function(target, effect)
    target:delMod(xi.mod.STR, effect:getPower())
    target:delMod(xi.mod.HASTE_ABILITY, 1000)
    target:delMod(xi.mod.ACC, 10)
end

return effect_object
