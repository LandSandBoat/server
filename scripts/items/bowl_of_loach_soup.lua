-----------------------------------
-- ID: 5671
-- Item: Bowl of Loach Soup
-- Food Effect: 4 Hrs, All Races
-----------------------------------
-- Dexterity 4
-- Agility 4
-- Accuracy 7% Cap 50
-- Ranged Accuracy 7% Cap 50
-- HP 7% Cap 50
-- Evasion 5
-----------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target)
    return xi.itemUtils.foodOnItemCheck(target, xi.foodType.BASIC)
end

itemObject.onItemUse = function(target)
    target:addStatusEffect(xi.effect.FOOD, 0, 0, 14400, 5671)
end

itemObject.onEffectGain = function(target, effect)
    target:addMod(xi.mod.DEX, 4)
    target:addMod(xi.mod.AGI, 4)
    target:addMod(xi.mod.FOOD_ACCP, 7)
    target:addMod(xi.mod.FOOD_ACC_CAP, 50)
    target:addMod(xi.mod.FOOD_RACCP, 7)
    target:addMod(xi.mod.FOOD_RACC_CAP, 50)
    target:addMod(xi.mod.FOOD_HPP, 7)
    target:addMod(xi.mod.FOOD_HP_CAP, 50)
    target:addMod(xi.mod.EVA, 5)
end

itemObject.onEffectLose = function(target, effect)
    target:delMod(xi.mod.DEX, 4)
    target:delMod(xi.mod.AGI, 4)
    target:delMod(xi.mod.FOOD_ACCP, 7)
    target:delMod(xi.mod.FOOD_ACC_CAP, 50)
    target:delMod(xi.mod.FOOD_RACCP, 7)
    target:delMod(xi.mod.FOOD_RACC_CAP, 50)
    target:delMod(xi.mod.FOOD_HPP, 7)
    target:delMod(xi.mod.FOOD_HP_CAP, 50)
    target:delMod(xi.mod.EVA, 5)
end

return itemObject
