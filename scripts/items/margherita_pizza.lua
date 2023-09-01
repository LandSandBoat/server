-----------------------------------
-- ID: 5695
-- Item: margherita_pizza
-- Food Effect: 3 hours, all Races
-----------------------------------
-- HP +30
-- Accuracy +10% (cap 8)
-- Attack +10% (cap 10)
-----------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target)
    return xi.itemUtils.foodOnItemCheck(target, xi.foodType.BASIC)
end

itemObject.onItemUse = function(target)
    target:addStatusEffect(xi.effect.FOOD, 0, 0, 10800, 5695)
end

itemObject.onEffectGain = function(target, effect)
    target:addMod(xi.mod.HP, 30)
    target:addMod(xi.mod.FOOD_ACCP, 10)
    target:addMod(xi.mod.FOOD_ACC_CAP, 8)
    target:addMod(xi.mod.FOOD_ATTP, 10)
    target:addMod(xi.mod.FOOD_ATT_CAP, 10)
end

itemObject.onEffectLose = function(target, effect)
    target:delMod(xi.mod.HP, 30)
    target:delMod(xi.mod.FOOD_ACCP, 10)
    target:delMod(xi.mod.FOOD_ACC_CAP, 8)
    target:delMod(xi.mod.FOOD_ATTP, 10)
    target:delMod(xi.mod.FOOD_ATT_CAP, 10)
end

return itemObject
