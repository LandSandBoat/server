-----------------------------------------
-- ID: 5784
-- Item: coconut_rusk
-- Food Effect: 30 Min, All Races
-----------------------------------------
-- High-quality success rate +3
-- Synthesis failure rate -6%
-----------------------------------------
require("scripts/globals/status")
require("scripts/globals/msg")
-----------------------------------------

function onItemCheck(target)
    local result = 0
    if target:hasStatusEffect(tpz.effect.FOOD) or target:hasStatusEffect(tpz.effect.FIELD_SUPPORT_FOOD) then
        result = tpz.msg.basic.IS_FULL
    end
    return result
end

function onItemUse(target)
    target:addStatusEffect(tpz.effect.FOOD, 0, 0, 1800, 5784)
end

function onEffectGain(target, effect)
    target:addMod(tpz.mod.SYNTH_HQ_RATE, 3)
    target:addMod(tpz.mod.SYNTH_FAIL_RATE, -6)
end

function onEffectLose(target, effect)
    target:delMod(tpz.mod.SYNTH_HQ_RATE, 3)
    target:delMod(tpz.mod.SYNTH_FAIL_RATE, -6)
end
