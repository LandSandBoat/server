-----------------------------------
-- ID: 5709
-- Item: Cotton Candy
-- Food Effect: 5 Min, All Races
-----------------------------------
-- MP % 10 Cap 200
-- MP Healing 3
-----------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target)
    return xi.itemUtils.foodOnItemCheck(target, xi.foodType.BASIC)
end

itemObject.onItemUse = function(target)
    target:addStatusEffect(xi.effect.FOOD, 0, 0, 300, 5709)
end

itemObject.onEffectGain = function(target, effect)
    target:addMod(xi.mod.FOOD_MPP, 10)
    target:addMod(xi.mod.FOOD_MP_CAP, 200)
    target:addMod(xi.mod.MPHEAL, 3)
end

itemObject.onEffectLose = function(target, effect)
    target:delMod(xi.mod.FOOD_MPP, 10)
    target:delMod(xi.mod.FOOD_MP_CAP, 200)
    target:delMod(xi.mod.MPHEAL, 3)
end

return itemObject
