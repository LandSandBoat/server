-----------------------------------
-- ID: 6216
-- Item: slice of pepperoni_pizza_+1
-- Food Effect: 60 minutes, all Races
-----------------------------------
-- HP +35
-- Strength 2
-- Accuracy 9% (caps @ 11)
-- Attack 10% (caps @ 16)
-----------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target)
    return xi.itemUtils.foodOnItemCheck(target, xi.foodType.BASIC)
end

itemObject.onItemUse = function(target)
    target:addStatusEffect(xi.effect.FOOD, 0, 0, 3600, 6216)
end

itemObject.onEffectGain = function(target, effect)
    target:addMod(xi.mod.HP, 35)
    target:addMod(xi.mod.STR, 2)
    target:addMod(xi.mod.FOOD_ACCP, 9)
    target:addMod(xi.mod.FOOD_ACC_CAP, 11)
    target:addMod(xi.mod.FOOD_ATTP, 10)
    target:addMod(xi.mod.FOOD_ATT_CAP, 16)
end

itemObject.onEffectLose = function(target, effect)
    target:delMod(xi.mod.HP, 35)
    target:delMod(xi.mod.STR, 2)
    target:delMod(xi.mod.FOOD_ACCP, 9)
    target:delMod(xi.mod.FOOD_ACC_CAP, 11)
    target:delMod(xi.mod.FOOD_ATTP, 10)
    target:delMod(xi.mod.FOOD_ATT_CAP, 16)
end

return itemObject
