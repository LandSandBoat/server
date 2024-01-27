-----------------------------------
-- ID: 5783
-- Item: chocolate_rusk
-- Food Effect: 30 Min, All Races
-----------------------------------
-- High-quality success rate +2
-- Synthesis failure rate -4%
-----------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target)
    return xi.itemUtils.foodOnItemCheck(target, xi.foodType.BASIC)
end

itemObject.onItemUse = function(target)
    target:addStatusEffect(xi.effect.FOOD, 0, 0, 1800, 5783)
end

itemObject.onEffectGain = function(target, effect)
    target:addMod(xi.mod.SYNTH_HQ_RATE, 2)
    target:addMod(xi.mod.SYNTH_FAIL_RATE, -4)
end

itemObject.onEffectLose = function(target, effect)
    target:delMod(xi.mod.SYNTH_HQ_RATE, 2)
    target:delMod(xi.mod.SYNTH_FAIL_RATE, -4)
end

return itemObject
