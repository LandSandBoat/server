-----------------------------------
-- ID: 5191
-- Item: dish_of_spaghetti_pescatora
-- Food Effect: 30Min, All Races
-----------------------------------
-- Health % 15
-- Health Cap 150
-- Vitality 3
-- Mind -1
-- Defense % 22
-- Defense Cap 65
-- Store TP 6
-----------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target)
    return xi.itemUtils.foodOnItemCheck(target, xi.foodType.BASIC)
end

itemObject.onItemUse = function(target)
    target:addStatusEffect(xi.effect.FOOD, 0, 0, 1800, 5191)
end

itemObject.onEffectGain = function(target, effect)
    target:addMod(xi.mod.FOOD_HPP, 15)
    target:addMod(xi.mod.FOOD_HP_CAP, 150)
    target:addMod(xi.mod.VIT, 3)
    target:addMod(xi.mod.MND, -1)
    target:addMod(xi.mod.FOOD_DEFP, 22)
    target:addMod(xi.mod.FOOD_DEF_CAP, 65)
    target:addMod(xi.mod.STORETP, 6)
end

itemObject.onEffectLose = function(target, effect)
    target:delMod(xi.mod.FOOD_HPP, 15)
    target:delMod(xi.mod.FOOD_HP_CAP, 150)
    target:delMod(xi.mod.VIT, 3)
    target:delMod(xi.mod.MND, -1)
    target:delMod(xi.mod.FOOD_DEFP, 22)
    target:delMod(xi.mod.FOOD_DEF_CAP, 65)
    target:delMod(xi.mod.STORETP, 6)
end

return itemObject
