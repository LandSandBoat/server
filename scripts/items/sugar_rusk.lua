-----------------------------------
-- ID: 5782
-- Item: sugar_rusk
-- Food Effect: 30 Min, All Races
-----------------------------------
-- High-quality success rate +1
-- Synthesis failure rate -2%
-----------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target)
    return xi.itemUtils.foodOnItemCheck(target, xi.foodType.BASIC)
end

itemObject.onItemUse = function(target)
    target:addStatusEffect(xi.effect.FOOD, 0, 0, 1800, 5782)
end

itemObject.onEffectGain = function(target, effect)
    target:addMod(xi.mod.SYNTH_HQ_RATE, 1)
    target:addMod(xi.mod.SYNTH_FAIL_RATE, -2)
end

itemObject.onEffectLose = function(target, effect)
    target:delMod(xi.mod.SYNTH_HQ_RATE, 1)
    target:delMod(xi.mod.SYNTH_FAIL_RATE, -2)
end

return itemObject
