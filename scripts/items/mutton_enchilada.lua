-----------------------------------
-- ID: 4348
-- Item: mutton_enchilada
-- Food Effect: 60Min, All Races
-----------------------------------
-- Magic 10
-- Strength 3
-- Vitality 1
-- Intelligence -1
-- Attack % 27
-- Attack Cap 35
-- Ranged ATT % 27
-- Ranged ATT Cap 35
-----------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target)
    return xi.itemUtils.foodOnItemCheck(target, xi.foodType.BASIC)
end

itemObject.onItemUse = function(target)
    target:addStatusEffect(xi.effect.FOOD, 0, 0, 3600, 4348)
end

itemObject.onEffectGain = function(target, effect)
    target:addMod(xi.mod.MP, 10)
    target:addMod(xi.mod.STR, 3)
    target:addMod(xi.mod.VIT, 1)
    target:addMod(xi.mod.INT, -1)
    target:addMod(xi.mod.FOOD_ATTP, 27)
    target:addMod(xi.mod.FOOD_ATT_CAP, 35)
    target:addMod(xi.mod.FOOD_RATTP, 27)
    target:addMod(xi.mod.FOOD_RATT_CAP, 35)
end

itemObject.onEffectLose = function(target, effect)
    target:delMod(xi.mod.MP, 10)
    target:delMod(xi.mod.STR, 3)
    target:delMod(xi.mod.VIT, 1)
    target:delMod(xi.mod.INT, -1)
    target:delMod(xi.mod.FOOD_ATTP, 27)
    target:delMod(xi.mod.FOOD_ATT_CAP, 35)
    target:delMod(xi.mod.FOOD_RATTP, 27)
    target:delMod(xi.mod.FOOD_RATT_CAP, 35)
end

return itemObject
