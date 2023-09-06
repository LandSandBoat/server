-----------------------------------
-- ID: 5146
-- Item: hedgehog_pie
-- Food Effect: 180Min, All Races
-----------------------------------
-- Health 55
-- Strength 6
-- Vitality 2
-- Intelligence -3
-- Mind 3
-- Magic Regen While Healing 2
-- Health Regen While Healing 2
-- Attack % 18
-- Attack Cap 90
-- Accuracy 5
-- Ranged ATT % 18
-- Ranged ATT Cap 90
-----------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target)
    return xi.itemUtils.foodOnItemCheck(target, xi.foodType.BASIC)
end

itemObject.onItemUse = function(target)
    target:addStatusEffect(xi.effect.FOOD, 0, 0, 10800, 5146)
end

itemObject.onEffectGain = function(target, effect)
    target:addMod(xi.mod.HP, 55)
    target:addMod(xi.mod.STR, 6)
    target:addMod(xi.mod.VIT, 2)
    target:addMod(xi.mod.INT, -3)
    target:addMod(xi.mod.MND, 3)
    target:addMod(xi.mod.HPHEAL, 2)
    target:addMod(xi.mod.MPHEAL, 2)
    target:addMod(xi.mod.FOOD_ATTP, 18)
    target:addMod(xi.mod.FOOD_ATT_CAP, 90)
    target:addMod(xi.mod.ACC, 5)
    target:addMod(xi.mod.FOOD_RATTP, 18)
    target:addMod(xi.mod.FOOD_RATT_CAP, 90)
end

itemObject.onEffectLose = function(target, effect)
    target:delMod(xi.mod.HP, 55)
    target:delMod(xi.mod.STR, 6)
    target:delMod(xi.mod.VIT, 2)
    target:delMod(xi.mod.INT, -3)
    target:delMod(xi.mod.MND, 3)
    target:delMod(xi.mod.HPHEAL, 2)
    target:delMod(xi.mod.MPHEAL, 2)
    target:delMod(xi.mod.FOOD_ATTP, 18)
    target:delMod(xi.mod.FOOD_ATT_CAP, 90)
    target:delMod(xi.mod.ACC, 5)
    target:delMod(xi.mod.FOOD_RATTP, 18)
    target:delMod(xi.mod.FOOD_RATT_CAP, 90)
end

return itemObject
