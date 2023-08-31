-----------------------------------
-- ID: 5178
-- Item: plate_of_dorado_sushi
-- Food Effect: 30Min, All Races
-----------------------------------
-- Dexterity 5
-- Accuracy % 15
-- Accuracy Cap 72
-- Ranged ACC % 15
-- Ranged ACC Cap 72
-- Sleep Resist 1
-- Enmity 4
-----------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target)
    return xi.itemUtils.foodOnItemCheck(target, xi.foodType.BASIC)
end

itemObject.onItemUse = function(target)
    target:addStatusEffect(xi.effect.FOOD, 0, 0, 1800, 5178)
end

itemObject.onEffectGain = function(target, effect)
    target:addMod(xi.mod.ENMITY, 4)
    target:addMod(xi.mod.DEX, 5)
    target:addMod(xi.mod.FOOD_ACCP, 15)
    target:addMod(xi.mod.FOOD_ACC_CAP, 72)
    target:addMod(xi.mod.FOOD_RACCP, 15)
    target:addMod(xi.mod.FOOD_RACC_CAP, 72)
    target:addMod(xi.mod.SLEEPRES, 1)
end

itemObject.onEffectLose = function(target, effect)
    target:delMod(xi.mod.ENMITY, 4)
    target:delMod(xi.mod.DEX, 5)
    target:delMod(xi.mod.FOOD_ACCP, 15)
    target:delMod(xi.mod.FOOD_ACC_CAP, 72)
    target:delMod(xi.mod.FOOD_RACCP, 15)
    target:delMod(xi.mod.FOOD_RACC_CAP, 72)
    target:delMod(xi.mod.SLEEPRES, 1)
end

return itemObject
