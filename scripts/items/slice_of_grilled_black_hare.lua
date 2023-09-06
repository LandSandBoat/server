-----------------------------------
-- ID: 4516
-- Item: slice_of_grilled_black_hare
-- Food Effect: 240Min, All Races
-----------------------------------
-- Strength 2
-- Intelligence -1
-- Attack % 20
-- Attack Cap 30
-----------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target)
    return xi.itemUtils.foodOnItemCheck(target, xi.foodType.BASIC)
end

itemObject.onItemUse = function(target)
    target:addStatusEffect(xi.effect.FOOD, 0, 0, 14400, 4516)
end

itemObject.onEffectGain = function(target, effect)
    target:addMod(xi.mod.STR, 2)
    target:addMod(xi.mod.INT, -1)
    target:addMod(xi.mod.FOOD_ATTP, 20)
    target:addMod(xi.mod.FOOD_ATT_CAP, 30)
end

itemObject.onEffectLose = function(target, effect)
    target:delMod(xi.mod.STR, 2)
    target:delMod(xi.mod.INT, -1)
    target:delMod(xi.mod.FOOD_ATTP, 20)
    target:delMod(xi.mod.FOOD_ATT_CAP, 30)
end

return itemObject
