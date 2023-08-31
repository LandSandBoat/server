-----------------------------------
-- ID: 5643
-- Item: serving_of_cibarious_cilbir
-- Food Effect: 4Hrs, All Races
-----------------------------------
-- HP % 6 (cap 150)
-- MP % 6 (cap 100)
-- HP recovered while healing 3
-- MP recovered while healing 4
-----------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target)
    return xi.itemUtils.foodOnItemCheck(target, xi.foodType.BASIC)
end

itemObject.onItemUse = function(target)
    target:addStatusEffect(xi.effect.FOOD, 0, 0, 14400, 5643)
end

itemObject.onEffectGain = function(target, effect)
    target:addMod(xi.mod.FOOD_HPP, 6)
    target:addMod(xi.mod.FOOD_HP_CAP, 150)
    target:addMod(xi.mod.FOOD_MPP, 6)
    target:addMod(xi.mod.FOOD_MP_CAP, 100)
    target:addMod(xi.mod.MPHEAL, 4)
    target:addMod(xi.mod.HPHEAL, 3)
end

itemObject.onEffectLose = function(target, effect)
    target:delMod(xi.mod.FOOD_HPP, 6)
    target:delMod(xi.mod.FOOD_HP_CAP, 150)
    target:delMod(xi.mod.FOOD_MPP, 6)
    target:delMod(xi.mod.FOOD_MP_CAP, 100)
    target:delMod(xi.mod.MPHEAL, 4)
    target:delMod(xi.mod.HPHEAL, 3)
end

return itemObject
