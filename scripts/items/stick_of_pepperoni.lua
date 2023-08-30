-----------------------------------
-- ID: 5660
-- Item: stick_of_pepperoni
-- Food Effect: 30Min, All Races
-----------------------------------
-- HP % 3 (assuming 3% from testing, no known cap)
-- Strength 3
-- Intelligence -1
-- Attack % 60 (assuming 60%, cap 30)
-----------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target)
    return xi.itemUtils.foodOnItemCheck(target, xi.foodType.BASIC)
end

itemObject.onItemUse = function(target)
    target:addStatusEffect(xi.effect.FOOD, 0, 0, 1800, 5660)
end

itemObject.onEffectGain = function(target, effect)
    target:addMod(xi.mod.FOOD_HPP, 3)
    target:addMod(xi.mod.FOOD_HP_CAP, 999)
    target:addMod(xi.mod.STR, 3)
    target:addMod(xi.mod.INT, -1)
    target:addMod(xi.mod.FOOD_ATTP, 60)
    target:addMod(xi.mod.FOOD_ATT_CAP, 30)
end

itemObject.onEffectLose = function(target, effect)
    target:delMod(xi.mod.FOOD_HPP, 3)
    target:delMod(xi.mod.FOOD_HP_CAP, 999)
    target:delMod(xi.mod.STR, 3)
    target:delMod(xi.mod.INT, -1)
    target:delMod(xi.mod.FOOD_ATTP, 60)
    target:delMod(xi.mod.FOOD_ATT_CAP, 30)
end

return itemObject
