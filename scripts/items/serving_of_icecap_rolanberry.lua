-----------------------------------
-- ID: 4556
-- Item: serving_of_icecap_rolanberry
-- Food Effect: 180Min, All Races
-----------------------------------
-- Magic % 19
-- Magic Cap 55
-- Intelligence 2
-- Wind Res 5
-----------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target)
    return xi.itemUtils.foodOnItemCheck(target, xi.foodType.BASIC)
end

itemObject.onItemUse = function(target)
    target:addStatusEffect(xi.effect.FOOD, 0, 0, 10800, 4556)
end

itemObject.onEffectGain = function(target, effect)
    target:addMod(xi.mod.FOOD_MPP, 19)
    target:addMod(xi.mod.FOOD_MP_CAP, 55)
    target:addMod(xi.mod.INT, 2)
    target:addMod(xi.mod.WIND_MEVA, 5)
end

itemObject.onEffectLose = function(target, effect)
    target:delMod(xi.mod.FOOD_MPP, 19)
    target:delMod(xi.mod.FOOD_MP_CAP, 55)
    target:delMod(xi.mod.INT, 2)
    target:delMod(xi.mod.WIND_MEVA, 5)
end

return itemObject
