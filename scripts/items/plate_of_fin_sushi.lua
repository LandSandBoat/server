-----------------------------------
-- ID: 5665
-- Item: plate_of_fin_sushi
-- Food Effect: 30Min, All Races
-----------------------------------
-- Intelligence 5
-- Accuracy % 16 (cap 76)
-- Ranged Accuracy % 16 (cap 76)
-- Resist Sleep +1
-----------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target)
    return xi.itemUtils.foodOnItemCheck(target, xi.foodType.BASIC)
end

itemObject.onItemUse = function(target)
    target:addStatusEffect(xi.effect.FOOD, 0, 0, 1800, 5665)
end

itemObject.onEffectGain = function(target, effect)
    target:addMod(xi.mod.INT, 5)
    target:addMod(xi.mod.FOOD_ACCP, 16)
    target:addMod(xi.mod.FOOD_ACC_CAP, 76)
    target:addMod(xi.mod.FOOD_RACCP, 16)
    target:addMod(xi.mod.FOOD_RACC_CAP, 76)
    target:addMod(xi.mod.SLEEPRES, 2)
end

itemObject.onEffectLose = function(target, effect)
    target:delMod(xi.mod.INT, 5)
    target:delMod(xi.mod.FOOD_ACCP, 16)
    target:delMod(xi.mod.FOOD_ACC_CAP, 76)
    target:delMod(xi.mod.FOOD_RACCP, 16)
    target:delMod(xi.mod.FOOD_RACC_CAP, 76)
    target:delMod(xi.mod.SLEEPRES, 2)
end

return itemObject
