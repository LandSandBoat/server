-----------------------------------
-- ID: 5779
-- Item: cherry_macaron
-- Food Effect: 30Min, All Races
-----------------------------------
-- Increases rate of synthesis success +3%
-- Increases synthesis skill gain rate +3%
-----------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target)
    return xi.itemUtils.foodOnItemCheck(target, xi.foodType.BASIC)
end

itemObject.onItemUse = function(target)
    target:addStatusEffect(xi.effect.FOOD, 0, 0, 1800, 5779)
end

itemObject.onEffectGain = function(target, effect)
    target:addMod(xi.mod.SYNTH_SUCCESS, 3)
    target:addMod(xi.mod.SYNTH_SKILL_GAIN, 3)
end

itemObject.onEffectLose = function(target, effect)
    target:delMod(xi.mod.SYNTH_SUCCESS, 3)
    target:delMod(xi.mod.SYNTH_SKILL_GAIN, 3)
end

return itemObject
