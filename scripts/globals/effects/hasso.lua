----------------------------------------
-- tpz.effect.HASSO
-- Straight +10% haste +10 Acc and scaling (lv) STR
-- also -50% FC
----------------------------------------
require("scripts/globals/status")
----------------------------------------
local effect_object = {}

function onEffectGain(target, effect)
    target:addMod(tpz.mod.STR, effect:getPower())
    target:addMod(tpz.mod.HASTE_ABILITY, 1000)
    target:addMod(tpz.mod.ACC, 10)
end

function onEffectTick(target, effect)
end

function onEffectLose(target, effect)
    target:delMod(tpz.mod.STR, effect:getPower())
    target:delMod(tpz.mod.HASTE_ABILITY, 1000)
    target:delMod(tpz.mod.ACC, 10)
end

return effect_object
