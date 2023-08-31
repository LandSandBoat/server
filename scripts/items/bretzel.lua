-----------------------------------
-- ID: 4391
-- Item: Bretzel
-- Food Effect: 3Min, All Races
-----------------------------------
-- Magic % 8
-- Magic Cap 55
-- Vitality 2
-----------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target)
    return xi.itemUtils.foodOnItemCheck(target, xi.foodType.BASIC)
end

itemObject.onItemUse = function(target)
    target:addStatusEffect(xi.effect.FOOD, 0, 0, 180, 4391)
end

itemObject.onEffectGain = function(target, effect)
    target:addMod(xi.mod.FOOD_MPP, 8)
    target:addMod(xi.mod.FOOD_MP_CAP, 55)
    target:addMod(xi.mod.VIT, 2)
end

itemObject.onEffectLose = function(target, effect)
    target:delMod(xi.mod.FOOD_MPP, 8)
    target:delMod(xi.mod.FOOD_MP_CAP, 55)
    target:delMod(xi.mod.VIT, 2)
end

return itemObject
