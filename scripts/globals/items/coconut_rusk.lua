-----------------------------------
-- ID: 5784
-- Item: coconut_rusk
-- Food Effect: 30 Min, All Races
-----------------------------------
-- High-quality success rate +3
-- Synthesis failure rate -6%
-----------------------------------
require("scripts/globals/msg")
-----------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target)
    local result = 0
    if target:hasStatusEffect(xi.effect.FOOD) then
        result = xi.msg.basic.IS_FULL
    end

    return result
end

itemObject.onItemUse = function(target)
    target:addStatusEffect(xi.effect.FOOD, 0, 0, 1800, 5784)
end

itemObject.onEffectGain = function(target, effect)
    target:addMod(xi.mod.SYNTH_HQ_RATE, 3)
    target:addMod(xi.mod.SYNTH_FAIL_RATE, -6)
end

itemObject.onEffectLose = function(target, effect)
    target:delMod(xi.mod.SYNTH_HQ_RATE, 3)
    target:delMod(xi.mod.SYNTH_FAIL_RATE, -6)
end

return itemObject
