-----------------------------------
-- ID: 5198
-- Item: Dish of Spaghetti Vongole Rosso +1
-- Food Effect: 60Min, All Races
-----------------------------------
-- Health % 20
-- Health Cap 95
-- Vitality 2
-- Mind -1
-- Defense % 25
-- Defense Cap 35
-- Store TP 6
-----------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target)
    return xi.itemUtils.foodOnItemCheck(target, xi.foodType.BASIC)
end

itemObject.onItemUse = function(target)
    target:addStatusEffect(xi.effect.FOOD, 0, 0, 3600, 5198)
end

itemObject.onEffectGain = function(target, effect)
    target:addMod(xi.mod.FOOD_HPP, 20)
    target:addMod(xi.mod.FOOD_HP_CAP, 95)
    target:addMod(xi.mod.VIT, 2)
    target:addMod(xi.mod.MND, -1)
    target:addMod(xi.mod.FOOD_DEFP, 25)
    target:addMod(xi.mod.FOOD_DEF_CAP, 35)
    target:addMod(xi.mod.STORETP, 6)
end

itemObject.onEffectLose = function(target, effect)
    target:delMod(xi.mod.FOOD_HPP, 20)
    target:delMod(xi.mod.FOOD_HP_CAP, 95)
    target:delMod(xi.mod.VIT, 2)
    target:delMod(xi.mod.MND, -1)
    target:delMod(xi.mod.FOOD_DEFP, 25)
    target:delMod(xi.mod.FOOD_DEF_CAP, 35)
    target:delMod(xi.mod.STORETP, 6)
end

return itemObject
