-----------------------------------
-- ID: 4349
-- Item: Bunny Ball
-- Food Effect: 240Min, All Races
-----------------------------------
-- Health 10
-- Strength 2
-- Vitality 2
-- Intelligence -1
-- Attack % 30 (cap 30)
-- Ranged ATT % 30 (cap 30)
-----------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target)
    return xi.itemUtils.foodOnItemCheck(target, xi.foodType.BASIC)
end

itemObject.onItemUse = function(target)
    target:addStatusEffect(xi.effect.FOOD, 0, 0, 14400, 4349)
end

itemObject.onEffectGain = function(target, effect)
    target:addMod(xi.mod.HP, 10)
    target:addMod(xi.mod.STR, 2)
    target:addMod(xi.mod.VIT, 2)
    target:addMod(xi.mod.INT, -1)
    target:addMod(xi.mod.FOOD_ATTP, 30)
    target:addMod(xi.mod.FOOD_ATT_CAP, 30)
    target:addMod(xi.mod.FOOD_RATTP, 30)
    target:addMod(xi.mod.FOOD_RATT_CAP, 30)
end

itemObject.onEffectLose = function(target, effect)
    target:delMod(xi.mod.HP, 10)
    target:delMod(xi.mod.STR, 2)
    target:delMod(xi.mod.VIT, 2)
    target:delMod(xi.mod.INT, -1)
    target:delMod(xi.mod.FOOD_ATTP, 30)
    target:delMod(xi.mod.FOOD_ATT_CAP, 30)
    target:delMod(xi.mod.FOOD_RATTP, 30)
    target:delMod(xi.mod.FOOD_RATT_CAP, 30)
end

return itemObject
