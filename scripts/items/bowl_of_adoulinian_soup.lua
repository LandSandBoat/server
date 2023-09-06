-----------------------------------
-- ID: 5998
-- Item: Bowl of Adoulin Soup
-- Food Effect: 180 Min, All Races
-----------------------------------
-- HP % 3 Cap 40
-- Vitality 3
-- Defense % 15 Cap 70
-- HP Healing 6
-----------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target)
    return xi.itemUtils.foodOnItemCheck(target, xi.foodType.BASIC)
end

itemObject.onItemUse = function(target)
    target:addStatusEffect(xi.effect.FOOD, 0, 0, 10800, 5998)
end

itemObject.onEffectGain = function(target, effect)
    target:addMod(xi.mod.FOOD_HPP, 3)
    target:addMod(xi.mod.FOOD_HP_CAP, 40)
    target:addMod(xi.mod.VIT, 3)
    target:addMod(xi.mod.FOOD_DEFP, 15)
    target:addMod(xi.mod.FOOD_DEF_CAP, 70)
    target:addMod(xi.mod.HPHEAL, 6)
end

itemObject.onEffectLose = function(target, effect)
    target:delMod(xi.mod.FOOD_HPP, 3)
    target:delMod(xi.mod.FOOD_HP_CAP, 40)
    target:delMod(xi.mod.VIT, 3)
    target:delMod(xi.mod.FOOD_DEFP, 15)
    target:delMod(xi.mod.FOOD_DEF_CAP, 70)
    target:delMod(xi.mod.HPHEAL, 6)
end

return itemObject
