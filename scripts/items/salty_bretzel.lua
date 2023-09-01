-----------------------------------
-- ID: 5182
-- Item: salty_bretzel
-- Food Effect: 5Min, All Races
-----------------------------------
-- Magic % 8
-- Magic Cap 60
-- Vitality 2
-----------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target)
    return xi.itemUtils.foodOnItemCheck(target, xi.foodType.BASIC)
end

itemObject.onItemUse = function(target)
    target:addStatusEffect(xi.effect.FOOD, 0, 0, 300, 5182)
end

itemObject.onEffectGain = function(target, effect)
    target:addMod(xi.mod.FOOD_MPP, 8)
    target:addMod(xi.mod.FOOD_MP_CAP, 60)
    target:addMod(xi.mod.VIT, 2)
end

itemObject.onEffectLose = function(target, effect)
    target:delMod(xi.mod.FOOD_MPP, 8)
    target:delMod(xi.mod.FOOD_MP_CAP, 60)
    target:delMod(xi.mod.VIT, 2)
end

return itemObject
