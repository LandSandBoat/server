-----------------------------------
-- ID: 5655
-- Item: coffeecake_muffin
-- Food Effect: 30Min, All Races
-----------------------------------
-- Mind 1
-- Strength -1
-- MP % 10 (cap 85)
-----------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target)
    return xi.itemUtils.foodOnItemCheck(target, xi.foodType.BASIC)
end

itemObject.onItemUse = function(target)
    target:addStatusEffect(xi.effect.FOOD, 0, 0, 1800, 5655)
end

itemObject.onEffectGain = function(target, effect)
    target:addMod(xi.mod.MND, 1)
    target:addMod(xi.mod.STR, -1)
    target:addMod(xi.mod.FOOD_MPP, 10)
    target:addMod(xi.mod.FOOD_MP_CAP, 85)
end

itemObject.onEffectLose = function(target, effect)
    target:delMod(xi.mod.MND, 1)
    target:delMod(xi.mod.STR, -1)
    target:delMod(xi.mod.FOOD_MPP, 10)
    target:delMod(xi.mod.FOOD_MP_CAP, 85)
end

return itemObject
