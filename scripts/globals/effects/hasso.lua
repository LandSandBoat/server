-----------------------------------
-- tpz.effect.HASSO
-- Straight +10% haste +10 Acc and scaling (lv) STR
-- also -50% FC
-----------------------------------
require("scripts/globals/status")
-----------------------------------
local effect_object = {}

effect_object.onEffectGain = function(target, effect)
    target:addMod(tpz.mod.STR, effect:getPower())
    target:addMod(tpz.mod.HASTE_ABILITY, 1000)
    target:addMod(tpz.mod.ACC, 10)
end

effect_object.onEffectTick = function(target, effect)
end

effect_object.onEffectLose = function(target, effect)
    target:delMod(tpz.mod.STR, effect:getPower())
    target:delMod(tpz.mod.HASTE_ABILITY, 1000)
    target:delMod(tpz.mod.ACC, 10)
end

return effect_object
