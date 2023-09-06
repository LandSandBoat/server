-----------------------------------
-- ID: 5978
-- Item: Plate of Felicifruit Gelatin
-- Food Effect: 180 Min, All Races
-----------------------------------
-- MP % 5 Cap 100
-- Intelligence +7
-- MP Healing +3
-----------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target)
    return xi.itemUtils.foodOnItemCheck(target, xi.foodType.BASIC)
end

itemObject.onItemUse = function(target)
    target:addStatusEffect(xi.effect.FOOD, 0, 0, 10800, 5978)
end

itemObject.onEffectGain = function(target, effect)
    target:addMod(xi.mod.FOOD_MPP, 5)
    target:addMod(xi.mod.FOOD_MP_CAP, 100)
    target:addMod(xi.mod.INT, 7)
    target:addMod(xi.mod.MPHEAL, 3)
end

itemObject.onEffectLose = function(target, effect)
    target:delMod(xi.mod.FOOD_MPP, 5)
    target:delMod(xi.mod.FOOD_MP_CAP, 100)
    target:delMod(xi.mod.INT, 7)
    target:delMod(xi.mod.MPHEAL, 3)
end

return itemObject
