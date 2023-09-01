-----------------------------------
-- ID: 5670
-- Item: Bowl of Loach Gruel
-- Food Effect: 4 Hrs, All Races
-----------------------------------
-- TODO: Make Group Effect
-- Dexterity 2
-- Agility 2
-- Accuracy 7% Cap 30
-- Ranged Accuracy 7% Cap 30
-- HP 7% Cap 30
-- Evasion 4
-----------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target)
    return xi.itemUtils.foodOnItemCheck(target, xi.foodType.BASIC)
end

itemObject.onItemUse = function(target)
    target:addStatusEffect(xi.effect.FOOD, 0, 0, 14400, 5670)
end

itemObject.onEffectGain = function(target, effect)
    target:addMod(xi.mod.DEX, 2)
    target:addMod(xi.mod.AGI, 2)
    target:addMod(xi.mod.FOOD_ACCP, 7)
    target:addMod(xi.mod.FOOD_ACC_CAP, 30)
    target:addMod(xi.mod.FOOD_RACCP, 7)
    target:addMod(xi.mod.FOOD_RACC_CAP, 30)
    target:addMod(xi.mod.FOOD_HPP, 7)
    target:addMod(xi.mod.FOOD_HP_CAP, 30)
    target:addMod(xi.mod.EVA, 4)
end

itemObject.onEffectLose = function(target, effect)
    target:delMod(xi.mod.DEX, 2)
    target:delMod(xi.mod.AGI, 2)
    target:delMod(xi.mod.FOOD_ACCP, 7)
    target:delMod(xi.mod.FOOD_ACC_CAP, 30)
    target:delMod(xi.mod.FOOD_RACCP, 7)
    target:delMod(xi.mod.FOOD_RACC_CAP, 30)
    target:delMod(xi.mod.FOOD_HPP, 7)
    target:delMod(xi.mod.FOOD_HP_CAP, 30)
    target:delMod(xi.mod.EVA, 4)
end

return itemObject
