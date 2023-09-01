-----------------------------------
-- ID: 4371
-- Item: slice_of_grilled_hare
-- Food Effect: 180Min, All Races
-----------------------------------
-- Strength 2
-- Intelligence -1
-- Attack % 30
-- Attack Cap 15
-----------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target)
    return xi.itemUtils.foodOnItemCheck(target, xi.foodType.BASIC)
end

itemObject.onItemUse = function(target)
    target:addStatusEffect(xi.effect.FOOD, 0, 0, 10800, 4371)
end

itemObject.onEffectGain = function(target, effect)
    target:addMod(xi.mod.STR, 2)
    target:addMod(xi.mod.INT, -1)
    target:addMod(xi.mod.FOOD_ATTP, 30)
    target:addMod(xi.mod.FOOD_ATT_CAP, 15)
end

itemObject.onEffectLose = function(target, effect)
    target:delMod(xi.mod.STR, 2)
    target:delMod(xi.mod.INT, -1)
    target:delMod(xi.mod.FOOD_ATTP, 30)
    target:delMod(xi.mod.FOOD_ATT_CAP, 15)
end

return itemObject
