-----------------------------------
-- ID: 6217
-- Item: slice of anchovy_pizza
-- Food Effect: 30 minutes, all Races
-----------------------------------
-- HP +30
-- DEX +1
-- Accuracy +9% (Cap 15)
-- Attack +10% (Cap 20)
-----------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target)
    return xi.itemUtils.foodOnItemCheck(target, xi.foodType.BASIC)
end

itemObject.onItemUse = function(target)
    target:addStatusEffect(xi.effect.FOOD, 0, 0, 1800, 6217)
end

itemObject.onEffectGain = function(target, effect)
    target:addMod(xi.mod.HP, 30)
    target:addMod(xi.mod.DEX, 1)
    target:addMod(xi.mod.FOOD_ACCP, 9)
    target:addMod(xi.mod.FOOD_ACC_CAP, 15)
    target:addMod(xi.mod.FOOD_ATTP, 10)
    target:addMod(xi.mod.FOOD_ATT_CAP, 20)
end

itemObject.onEffectLose = function(target, effect)
    target:delMod(xi.mod.HP, 30)
    target:delMod(xi.mod.DEX, 1)
    target:delMod(xi.mod.FOOD_ACCP, 9)
    target:delMod(xi.mod.FOOD_ACC_CAP, 15)
    target:delMod(xi.mod.FOOD_ATTP, 10)
    target:delMod(xi.mod.FOOD_ATT_CAP, 20)
end

return itemObject
